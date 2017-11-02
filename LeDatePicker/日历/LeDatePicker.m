//
//  LeDatePicker.m
//  LeDatePicker
//
//  Created by 刘浩宇 on 17/11/1.
//  Copyright © 2017年 房王网. All rights reserved.
//

#import "LeDatePicker.h"
#import "LeDatePickerModel.h"

@interface LeDatePicker()<UIScrollViewDelegate>{
    UIScrollView *_daysScrollView;
    NSCalendar*_calendar;
    NSArray *_dataSourceArr;
    NSMutableArray *_uIdataArr;
}
@property (nonatomic, strong) NSDate *selectedDate;
@end

@implementation LeDatePicker

- (instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *)date{
    if (self = [super initWithFrame:frame]) {
        [self sept:date];
        _uIdataArr = [NSMutableArray array];
    }
    return self;
}
- (void)sept:(NSDate *)date{
    _daysScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _daysScrollView.showsHorizontalScrollIndicator = NO;
//    _daysScrollView.pagingEnabled = YES;
    _daysScrollView.delegate = self;
    [self addSubview:_daysScrollView];
    [self getAllDaysWithCalender:date];
   
    
    NSInteger days = [self getNumberOfDaysInMonth];
    
    CGFloat itemWitdh = [UIScreen mainScreen].bounds.size.width/7.0;
    _daysScrollView.contentSize = CGSizeMake(days *itemWitdh, 0);
    [_daysScrollView setContentOffset:CGPointMake((days-7)*itemWitdh, 0)];
    
    for (int index = 0;index<[_dataSourceArr count];index++) {
        LeDatePickerModel *model = _dataSourceArr[index];
        ASDayView *pickerItem = [[ASDayView alloc]initWithFrame:CGRectMake(index*itemWitdh, 0, itemWitdh, 55)];
        if (index == [_dataSourceArr count]-1) {
            pickerItem.dataButton.backgroundColor = COLOR(74 ,144 ,226);
        }
        [pickerItem.dataButton setTitle:[NSString stringWithFormat:@"%@",@(model.day)] forState:UIControlStateNormal];
        pickerItem.titleLabel.text = [self stringWithInteger:model.weekday];
        [pickerItem.dataButton addTarget:self action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        pickerItem.dataButton.tag = index+10023;
        [_daysScrollView addSubview:pickerItem];
    }
}
- (NSString *)stringWithInteger:(NSInteger)integer{
    switch (integer) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
        default:
            return @"";
            break;
    }
    
}
- (void)dayButtonPressed:(UIButton*)sender {
   // _lastSelectedButton.dataButton.selected = NO;
    if ([_dataSourceArr count]>sender.tag-10023) {
        //1.刷新ui
        [_dataSourceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [self viewWithTag:idx+10023];
            if (btn == sender) {
                
                btn.backgroundColor = COLOR(74 ,144 ,226);
            }else{
                btn.backgroundColor = [UIColor clearColor];
            }
        }];
        //取值传值
        LeDatePickerModel *model = _dataSourceArr[sender.tag - 10023];
        self.selectedDate = model.date;
        if (self.selectDataBlock) {
            self.selectDataBlock();
        }
    }
}


// 获取当月的天数
- (NSInteger)getNumberOfDaysInMonth
{
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDate * currentDate = [NSDate date]; // 这个日期可以你自己给定
    NSRange range = [_calendar rangeOfUnit:NSDayCalendarUnit
                                    inUnit: NSMonthCalendarUnit
                                   forDate:currentDate];
    NSLog(@"%lu",(unsigned long)range.length);
    return range.length;
}

/**
 *  获取当月中所有天数是周几
 */
- (void) getAllDaysWithCalender:(NSDate *)currentDate
{
    NSUInteger dayCount = [self getNumberOfDaysInMonth]; //一个月的总天数
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM"];
    //    NSString * str = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < dayCount; i++) {
        NSString *suDateString = [self getBeforDateTimes:@"YYYYMMddHHmmss" daTe:currentDate beforeMonth:0 berforeDay:-i];
        //        NSString * sr = [NSString stringWithFormat:@"%@-%ld",str,i];
        NSDate *suDate = [formatter dateFromString:suDateString];
        NSDateComponents *comps = [self getweekDayWithDate:suDate];
        LeDatePickerModel *model = [[LeDatePickerModel alloc]init];
        model.day = comps.day;
        model.weekday = comps.weekday;
        model.date = suDate;
        [allDaysArray insertObject:model atIndex:0];
    }
    _dataSourceArr = allDaysArray;
    
    NSLog(@"allDaysArray %@",allDaysArray);
}
- (NSString*)getBeforDateTimes:(NSString *)forMatString daTe:(NSDate *)mydate beforeMonth:(NSInteger)month berforeDay:(NSInteger)day{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:forMatString];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}
/**
 *  获得某天的数据
 *
 *  获取指定的日期是星期几
 */
- (id) getweekDayWithDate:(NSDate *) date
{
    //    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    /*
     NSCalendarUnitYear               = kCFCalendarUnitYear,
     NSCalendarUnitMonth              = kCFCalendarUnitMonth,
     NSCalendarUnitDay                = kCFCalendarUnitDay,
     NSCalendarUnitHour               = kCFCalendarUnitHour,
     NSCalendarUnitMinute             = kCFCalendarUnitMinute,
     NSCalendarUnitSecond
     */
    NSDateComponents *comps = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    return comps;
    
}


@end




