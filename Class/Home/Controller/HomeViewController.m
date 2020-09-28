//
//  HomeViewController.m
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HomeViewController.h"
#import <GPUImage/GPUImage.h>
@interface HomeViewController ()
@property(nonatomic,strong)GPUImageVideoCamera *videoCamera;
@property(nonatomic,strong)GPUImageView *displayView;
@end

@implementation HomeViewController

-(void)loadView
{
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:self.displayView];
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.videoCamera addTarget:self.displayView];
    [self.videoCamera startCameraCapture];
}

#pragma mark -- getter

-(GPUImageVideoCamera *)videoCamera
{
    if (_videoCamera == nil) {
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
        [_videoCamera setOutputImageOrientation:UIInterfaceOrientationPortrait];
        _videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    }
    return _videoCamera;
}

-(GPUImageView *)displayView
{
    if (_displayView == nil) {
        _displayView = [[GPUImageView alloc] init];
        _displayView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    }
    return _displayView;
}

@end
