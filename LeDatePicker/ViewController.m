//
//  ViewController.m
//  LeDatePicker
//
//  Created by 刘浩宇 on 17/11/1.
//  Copyright © 2017年 房王网. All rights reserved.
//

#import "ViewController.h"
#import "LeDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LeDatePicker *picker = [[LeDatePicker alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 55) withDate:[NSDate date]];
    __weak typeof(picker)weakSelf = picker;
    picker.selectDataBlock = ^{
        NSLog(@"%@",weakSelf.selectedDate);
    };
    [self.view addSubview:picker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
