//
//  HomeViewController.m
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeCell.h"
#import "UserInfoModel.h"
#import "ActivityModel.h"
//#import "ForecastEditViewController.h"
//#import "RRJForecastDeatilController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HandelHeaderAction,HandelCellAction>
@property (nonatomic , strong ) UserInfoModel *userInfoModel;
@property (nonatomic , strong ) NSMutableArray *classListArray;
@property (nonatomic , strong ) UITableView *tableView;
@property (nonatomic , strong ) HomeHeaderView *headerView;
@property (nonatomic , strong ) UIView *sectionHeaderView;
@end

@implementation HomeViewController

-(void)loadView
{
    [super loadView];
    [self setTitle:@"课程盒子"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self addDefaultView:self.tableView title:@"暂无课程,赶快去创建吧!" imageName:@"暂无课程"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showLoadText:@"加载中..."];
    [self refreshThePage];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -- loadData

-(void)refreshThePage
{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //创建全局并行
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //获取个人信息
    dispatch_group_async(group, queue, ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]],@"user_id", nil];
        [HttpInterface getUserInfoByParameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.userInfoModel = [UserInfoModel mj_objectWithKeyValues:responseObject];
            dispatch_semaphore_signal(semaphore);
        } failed:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handelRequestFailed:error];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    //获取课程列表
    dispatch_group_async(group, queue, ^{
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"page", nil];
        [HttpInterface getUserClassListByParameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dispatch_semaphore_signal(semaphore);
            self.classListArray = [ActivityModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"activities"]];
        } failed:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handelRequestFailed:error];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    //刷新UI
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hidenHUD];
            [self.tipView setHidden:YES];
            if (self.userInfoModel.user_id == 0) {
                [MBProgressHUD showWarningInfo:@"网络加载错误"];
            }else
            {
                [self.headerView setUserInfoModel:self.userInfoModel];
                CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                CGRect fream = self.headerView.frame;
                fream.size.height = height;
                self.headerView.frame = fream;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
                NSLog(@"**********%lu",(unsigned long)self.classListArray.count);
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
            if (self.classListArray.count >= 10) {
                [self.tableView.mj_footer setHidden:NO];
            }else if (self.classListArray.count == 0)
            {
                [self.tipView setHidden:NO];
                [self.tableView.mj_footer setHidden:YES];
            }else
            {
                [self.tableView.mj_footer setHidden:YES];
            }
        });
    });
}

-(void)loadMoreData
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:(ceil(self.classListArray.count/10.0)+1)],@"page", nil];
    [HttpInterface getUserClassListByParameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelRequestSuccess:responseObject shouldcontinue:^(BOOL shouldcontinue) {
            if (shouldcontinue) {
                NSArray *tempArray = [ActivityModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"activities"]];
                [self.classListArray addObjectsFromArray:tempArray];
                [self.tableView reloadData];
                if (tempArray.count >= 10)
                {
                    [self.tableView.mj_footer endRefreshing];
                }else
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }];
    } failed:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handelRequestFailed:error];
    }];
}

#pragma mark -- HandelHeaderAction

-(void)setting
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)createClass
{
//    ForecastEditViewController *vc = [[ForecastEditViewController alloc] init];
//    [vc setDelegate:self];
//    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark -- HandelCellAction

-(void)handelAction:(ActivityModel *)activitimodel
{
//    ForecastEditViewController *vc = [[ForecastEditViewController alloc] init];
//    [vc setForecastToEdit:(MyForecastActivities *)activitimodel];
//    [vc setDelegate:self];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- ForecastEditDelegate

-(void)shouldUpdateList
{
    [MBProgressHUD showLoadText:@"数据更新中..."];
    [self refreshThePage];
}

#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeCell class])];
    [cell setDelegate:self];
    if (indexPath.row < self.classListArray.count) {
        [cell setActivityModel:self.classListArray[indexPath.row]];
    }
    return cell;
}

#pragma mark -- UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.classListArray.count > 0) {
        return self.sectionHeaderView;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.classListArray.count > 0) {
        return 45;
    }else
    {
        return CGFLOAT_MIN;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row < self.classListArray.count) {
//        ActivityModel *activity = self.classListArray[indexPath.row];
//        RRJForecastDeatilController *vc = [[RRJForecastDeatilController alloc] init];
//        [vc setActivitiesID:activity.ID];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

#pragma mark -- getter

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 114;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setTableFooterView:[UIView new]];
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:NSStringFromClass([HomeCell class])];
        [_tableView setMj_header:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshThePage)]];
        [_tableView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)]];
    }
    return _tableView;
}

-(HomeHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[HomeHeaderView alloc] init];
        [_headerView setDelegate:self];
    }
    return _headerView;
}

-(UIView *)sectionHeaderView
{
    if (_sectionHeaderView == nil) {
        UIView *sectionHeaderView = [[UITool shareTool] createView:[UIColor colorFromHexString:@"FFFFFF"] cornerRadius:UITOOL_NEGATIVE_NUMBER];
        UILabel *classLabel = [[UITool shareTool] createLabel:@"课程" textColor:[UIColor colorFromHexString:@"111111"] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft numberOfLine:1];
        [sectionHeaderView addSubview:classLabel];
        [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sectionHeaderView.mas_left).offset(15);
            make.top.mas_equalTo(sectionHeaderView.mas_top).offset(10);
            make.bottom.mas_equalTo(sectionHeaderView.mas_bottom).offset(-10);
        }];
        _sectionHeaderView = sectionHeaderView;
    }
    return _sectionHeaderView;
}

@end
