//
//  LeDatePicker.h
//  LeDatePicker
//
//  Created by 刘浩宇 on 17/11/1.
//  Copyright © 2017年 房王网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDayView.h"
#import "Masonry/Masonry.h"
@interface LeDatePicker : UIView

@property (nonatomic,copy) void (^selectDataBlock)();

@property (nonatomic, readonly) NSDate *selectedDate;

- (instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *)date;

@end


