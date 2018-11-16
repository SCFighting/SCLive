//
//  NoDataView.m
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *imageTitleLabel;
@property(nonatomic,strong)UILabel *tipLabel;
@end

@implementation NoDataView

-(instancetype)initWithTitle:(NSString *)title imageTitle:(NSString *)imageTitle;{
    if (self = [super init]) {
        [self setupSubviews];
        [self setupSubviewConstaints];
        [self.imageTitleLabel setText:imageTitle];
        [self.tipLabel setText:title];
    }
    return self;
}

-(void)setupSubviews
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noDataImage"]];
    [self addSubview:self.imageView];
    
    self.imageTitleLabel = [[UILabel alloc] init];
    [self.imageTitleLabel setTextColor:[UIColor colorFromHexString:@"ADADAD"]];
    [self.imageTitleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.imageTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.imageView addSubview:self.imageTitleLabel];
    
    self.tipLabel = [[UILabel alloc] init];
    [self.tipLabel setTextColor:[UIColor colorFromHexString:@"ADADAD"]];
    [self.tipLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.tipLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.tipLabel];
}

-(void)setupSubviewConstaints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView.mas_centerY).offset(-10);
        make.centerX.mas_equalTo(self.imageView);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(17);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

@end
