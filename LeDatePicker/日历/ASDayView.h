//
//  ASDayView.h
//  LeDatePicker
//
//  Created by 刘浩宇 on 17/11/1.
//  Copyright © 2017年 房王网. All rights reserved.
//
#define RGBA(r, g, b, a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define COLORWITHRED(_redNum_,_greenNum_,_blueNum_,_alpha_)  [UIColor colorWithRed:_redNum_/255.0 green:_greenNum_/255.0  blue:_blueNum_/255.0  alpha:_alpha_]
#define COLOR(_redNum_,_greenNum_,_blueNum_) COLORWITHRED(_redNum_, _greenNum_, _blueNum_, 1)
#define FONT(size)  ([UIFont systemFontOfSize:size])


#import <UIKit/UIKit.h>

@interface ASDayView : UIView

/**
 日期按钮
 */
@property (nonatomic,strong) UIButton *dataButton;
@property (nonatomic, strong) UILabel *titleLabel;//日期显示

@end
