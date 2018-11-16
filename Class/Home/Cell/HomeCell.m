//
//  HomeCell.m
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HomeCell.h"
#import "ActivityModel.h"
@interface HomeCell()
@property (nonatomic , strong ) UIImageView *posterImageView;
@property (nonatomic , strong ) UILabel *titleLabel;
@property (nonatomic , strong ) UILabel *timeLabel;
@property (nonatomic , strong ) UILabel *popularLabel;
@property (nonatomic , strong ) UILabel *priceLabel;
@property (nonatomic , strong ) UIButton *detailButton;
@end

@implementation HomeCell

#pragma mark - setter

-(void)setActivityModel:(ActivityModel *)activityModel
{
    _activityModel = activityModel;
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:activityModel.background]];
    [self.titleLabel setText:activityModel.title];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    [self.timeLabel setTextColor:[UIColor colorFromHexString:@"BF9858"]];
    if ([NSString isDateInYesterday:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]) //昨天
    {
        [self.timeLabel setText:[NSString stringWithFormat:@"昨天 %@",[format stringFromDate:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]]];
    }else if ([NSString isDateInToday:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]) //今天
    {
        [self.timeLabel setText:[NSString stringWithFormat:@"今天 %@",[format stringFromDate:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]]];
    }else if ([NSString isDateInTomorrow:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]) //明天
    {
        [self.timeLabel setText:[NSString stringWithFormat:@"明天 %@",[format stringFromDate:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]]];
    }else
    {
        [format setDateFormat:@"MM-dd HH:mm"];
        [self.timeLabel setTextColor:[UIColor colorFromHexString:@"B3B3B3"]];
        [self.timeLabel setText:[NSString stringWithFormat:@"%@",[format stringFromDate:[NSDate dateWithTimeIntervalSince1970:activityModel.started_at]]]];
    }
    [self.popularLabel setText:[NSString stringWithFormat:@"%ld人报名",(long)activityModel.popularity]];
    [self.priceLabel setText:[NSString stringWithFormat:@"%@",activityModel.price > 0 ? [NSString stringWithFormat:@"¥ %.2f",activityModel.price] :@"免费"]];
}

#pragma mark -- Events

-(void)detailButtonClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(handelAction:)]) {
        [_delegate handelAction:_activityModel];
    }
}

#pragma mark -- UI

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupSubviewConstaints];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(void)setupSubviews
{
    [self.contentView addSubview:self.posterImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.popularLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.detailButton];
}

-(void)setupSubviewConstaints
{
    [self.posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(150, 84));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.posterImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.posterImageView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.centerY.mas_equalTo(self.posterImageView.mas_centerY);
    }];
    
    [self.popularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.posterImageView.mas_bottom);
        make.left.mas_equalTo(self.timeLabel.mas_left);
    }];
    
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.posterImageView.mas_bottom);
    }];
}

#pragma mark -- getter

-(UIImageView *)posterImageView
{
    if (_posterImageView == nil) {
        _posterImageView = [[UITool shareTool] createImageView:nil cornerRadius:1.0];
    }
    return _posterImageView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"111111"] font:[UIFont systemFontOfSize:17.0] textAlignment:NSTextAlignmentLeft numberOfLine:1];
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"BF9858"] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft numberOfLine:1];
    }
    return _timeLabel;
}

-(UILabel *)popularLabel
{
    if (_popularLabel == nil) {
        _popularLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"B3B3B3"] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft numberOfLine:1];
    }
    return _popularLabel;
}

-(UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UITool shareTool] createLabel:nil textColor:[UIColor colorFromHexString:@"FA5D5C"] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft numberOfLine:1];
    }
    return _priceLabel;
}

-(UIButton *)detailButton
{
    if (_detailButton == nil) {
        _detailButton = [[UITool shareTool] createButton:@"..." highlightTitle:@"..." disablTitle:nil selectTitle:nil normalColor:[UIColor colorFromHexString:@"9F9F9F"] highlightColor:[UIColor colorFromHexString:@"FA5D5C"] disablColor:nil selectColor:nil font:[UIFont boldSystemFontOfSize:16] backgroundColor:nil cornerRadius:UITOOL_NEGATIVE_NUMBER];
        [_detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

@end
