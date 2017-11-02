//
//  ASDayView.m
//  LeDatePicker
//
//  Created by 刘浩宇 on 17/11/1.
//  Copyright © 2017年 房王网. All rights reserved.
//

#import "ASDayView.h"
#import "Masonry.h"
@implementation ASDayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)creatUI{
    
    self.titleLabel =({
        UILabel *label = [[UILabel alloc]init];
        label.textColor = COLOR(34, 34, 34);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.leading.equalTo(self);
            make.height.equalTo(@24);
            make.trailing.equalTo(self);
        }];
        label;
    });
    
    self.dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dataButton.layer.masksToBounds = YES;
    self.dataButton.layer.cornerRadius = 12;
    [_dataButton setTitleColor:COLOR(100, 100, 100) forState:UIControlStateNormal];
    [self.dataButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.dataButton];
    [self.dataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@24);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@24);
    }];
}
@end
