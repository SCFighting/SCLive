//
//  SCCatchCrash.m
//  SCLive
//
//  Created by SC on 2018/10/27.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "SCCatchCrash.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
volatile int32_t exceptionNumber = 0;
const int32_t exceptionMaximum = 10;
// 沙盒的地址
NSString * applicationDocumentsDirectory()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@implementation SCCatchCrash

//获取堆栈信息
+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i ++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

#pragma mark 异常处理
- (void)handleException:(NSException *)exception{
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    
    //捕获到异常后处理
    NSArray *callStack = [[exception userInfo]objectForKey:@"UncaughtExceptionHandlerAddressesKey"];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    //错误信息
    NSString *crashContent = [NSString stringWithFormat:@"crashName:%@ AND crashReason:%@ AND callStackSymbols:%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    //有效信息自行拼接
    NSString *message = [NSString stringWithFormat:@"%@", crashContent];
    //本地存储
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    // 将一个txt文件写入沙盒
    [message writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if ([[exception name] isEqual:@"UncaughtExceptionHandlerSignalExceptionName"])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:@"UncaughtExceptionHandlerSignalKey"] intValue]);
    }
    else
    {
        [exception raise];
    }
}

@end

#pragma mark 普通异常处理
//处理exception报错
void handleException(NSException *exception)
{
    int32_t exceptionCount = OSAtomicIncrement32(&exceptionNumber);
    if (exceptionCount > exceptionMaximum)
    {
        return;
    }
    
    NSArray *callStack = [SCCatchCrash backtrace];
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:@"UncaughtExceptionHandlerAddressesKey"];
    
    [[[SCCatchCrash alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:[NSException exceptionWithName:[exception name]reason:[exception reason]userInfo:userInfo]waitUntilDone:YES];
}

#pragma mark 异常信号处理
//处理signal报错
void signalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&exceptionNumber);
    if (exceptionCount > exceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]forKey:@"UncaughtExceptionHandlerSignalKey"];
    
    NSArray *callStack = [SCCatchCrash backtrace];
    [userInfo setObject:callStack forKey:@"UncaughtExceptionHandlerAddressesKey"];
    
    [[[SCCatchCrash alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:[NSException exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
                                        reason:[NSString stringWithFormat:@"Signal %d was raised.",
                                                signal]userInfo:userInfo]waitUntilDone:YES];
}

#pragma mark 注册异常处理
void RegisterExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&handleException);
    
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
}

void DeleteCrashInfo(void)
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    NSString *uniquePath=[applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave)
    {
        NSLog(@"no  have");
        return ;
    }else
    {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele)
        {
            NSLog(@"dele success");
        }else
        {
            NSLog(@"dele fail");
        }
    }
}
