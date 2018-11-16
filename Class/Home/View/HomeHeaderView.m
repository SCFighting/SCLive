//
//  HomeHeaderView.m
//  SCLive
//
//  Created by SC on 2018/11/9.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UserInfoModel.h"
@interface HomeHeaderView()
@property (nonatomic , strong ) UIView *containerView;
@property (nonatomic , strong ) UIImageView *avatarImageView;
@property (nonatomic , strong ) UILabel *nickNameLabel;
@property (nonatomic , strong ) UIImageView *vipTagImageView;
@property (nonatomic , strong ) UILabel *descriptionLabel;
@property (nonatomic , strong ) UILabel *classLabel;
@property (nonatomic , strong ) UIView *divideOneView;
@property (nonatomic , strong ) UILabel *popularLabel;
@property (nonatomic , strong ) UIView *divideTwoView;
@property (nonatomic , strong ) UIButton *settingButton;
@property (nonatomic , strong ) UIButton *createClassButton;
@end

@implementation HomeHeaderView

#pragma mark -- setter

-(void)setUserInfoModel:(UserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userInfoModel.avatar]];
    [self.nickNameLabel setText:[NSString isBlankString:userInfoModel.displayname] ? userInfoModel.nickname : userInfoModel.displayname];
    [self.descriptionLabel setText:userInfoModel.Description];
    [self.classLabel setAttributedText:[self createAttributeTextWithCount:userInfoModel.activities_count type:@"课程"]];
    [self.popularLabel setAttributedText:[self createAttributeTextWithCount:userInfoModel.fans_count type:@"人气"]];
}

- (NSMutableAttributedString *)createAttributeTextWithCount:(NSInteger)count type:(NSString *)type
{
    NSString *countStr = [NSString stringWithFormat:@"%ld\n",(long)count];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",countStr,type]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"222222"] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, countStr.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(countStr.length, 2)];
    return attributedString;
}

#pragma mark - Events

-(void)settingButtonClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(setting)]) {
        [_delegate setting];
    }
}

-(void)createClassButtonClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(createClass)]) {
        [_delegate createClass];
    }
}

#pragma mark - UI

-(instancetype)init
{
    if (self = [super init])
    {
        [self setupSubviews];
        [self setupSubviewConstaints];
        [self setBackgroundColor:[UIColor colorFromHexString:@"F4F4F4"]];
    }
    return self;
}

-(void)setupSubviews
{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.avatarImageView];
    [self.containerView addSubview:self.nickNameLabel];
    [self.containerView addSubview:self.descriptionLabel];
    [self.containerView addSubview:self.classLabel];
    [self.containerView addSubview:self.divideOneView];
    [self.containerView addSubview:self.popularLabel];
    [self.containerView addSubview:self.divideTwoView];
    [self.containerView addSubview:self.settingButton];
    [self.containerView addSubview:self.createClassButton];
}

-(void)setupSubviewConstaints
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset(15);
        make.top.mas_equalTo(self.containerView.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(75.0, 75.0));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.avatarImageView.mas_top).offset(7);
        make.right.mas_equalTo(self.containerView.mas_right).offset(-15);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nickNameLabel);
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(3);
    }];
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.containerView.mas_centerX).multipliedBy(1.0/3.0);
    }];
    
    [self.divideOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView.mas_centerX).multipliedBy(2.0/3.0);
        make.centerY.mas_equalTo(self.classLabel);
        make.height.mas_equalTo(self.classLabel);
        make.width.mas_equalTo(1);
    }];
    
    [self.popularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView.mas_centerX);
        make.centerY.mas_equalTo(self.classLabel.mas_centerY);
    }];
    
    [self.divideTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView.mas_centerX).multipliedBy(4.0/3.0);
        make.centerY.mas_equalTo(self.popularLabel);
        make.height.mas_equalTo(self.popularLabel);
        make.width.mas_equalTo(1);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView.mas_centerX).multipliedBy(5.0/3.0);
        make.centerY.mas_equalTo(self.divideTwoView.mas_centerY);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 6.0);
    }];
    
    [self.createClassButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset(15);
        make.right.mas_equalTo(self.containerView.mas_right).offset(-15);
        make.top.mas_equalTo(self.popularLabel.mas_bottom).offset(47);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(-25);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark -- getter
-(UIView *)containerView
{
    if (_containerView == nil) {
        _containerView = [[UITool shareTool] createView:[UIColor colorFromHexString:@"FFFFFF"] cornerRadius:UITOOL_NEGATIVE_NUMBER];
    }
    return _containerView;
}

-(UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UITool shareTool] createImageView:nil cornerRadius:75.0/2.0];
    }
    return _avatarImageView;
}

-(UILabel *)nickNameLabel
{
    if (_nickNameLabel == nil)
    {
        _nickNameLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"202020"] font:[UIFont boldSystemFontOfSize:20] textAlignment:NSTextAlignmentLeft numberOfLine:1];
    }
    return _nickNameLabel;
}

-(UILabel *)descriptionLabel
{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"222222"] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numberOfLine:2];
    }
    return _descriptionLabel;
}

-(UILabel *)classLabel
{
    if (_classLabel == nil) {
        _classLabel = [[UITool shareTool] createLabel:nil textColor:nil font:nil textAlignment:NSTextAlignmentCenter numberOfLine:0];
    }
    return _classLabel;
}

-(UIView *)divideOneView
{
    if (_divideOneView == nil) {
        _divideOneView = [[UITool shareTool] createView:[UIColor colorFromHexString:@"E0E0E0"] cornerRadius:UITOOL_NEGATIVE_NUMBER];
    }
    return _divideOneView;
}

-(UILabel *)popularLabel
{
    if (_popularLabel == nil) {
        _popularLabel = [[UITool shareTool] createLabel:nil textColor:nil font:nil textAlignment:NSTextAlignmentCenter numberOfLine:0];
    }
    return _popularLabel;
}

-(UIView *)divideTwoView
{
    if (_divideTwoView == nil)
    {
        _divideTwoView = [[UITool shareTool] createView:[UIColor colorFromHexString:@"E0E0E0"] cornerRadius:UITOOL_NEGATIVE_NUMBER];
    }
    return _divideTwoView;
}

-(UIButton *)settingButton
{
    if (_settingButton == nil) {
        _settingButton = [[UITool shareTool] createButton:@"设置" highlightTitle:@"设置" disablTitle:nil selectTitle:nil normalColor:[UIColor colorFromHexString:@"FFA800"] highlightColor:[UIColor colorFromHexString:@"FFFFFF"] disablColor:nil selectColor:nil font:[UIFont systemFontOfSize:16] backgroundColor:[UIColor colorFromHexString:@"FFECC7"] cornerRadius:35.0/2.0];
        [_settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

-(UIButton *)createClassButton
{
    if (_createClassButton == nil)
    {
        _createClassButton = [[UITool shareTool] createButton:@"创建课程" highlightTitle:@"创建课程" disablTitle:nil selectTitle:nil normalColor:[UIColor colorFromHexString:@"FFFFFF"] highlightColor:[UIColor colorFromHexString:@"000000"] disablColor:nil selectColor:nil font:[UIFont systemFontOfSize:16] backgroundColor:[UIColor colorFromHexString:@"FA5D5C"] cornerRadius:45.0/2.0];
        [_createClassButton addTarget:self action:@selector(createClassButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createClassButton;
}

@end
