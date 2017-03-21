//
//  ViewController.m
//  JLDoubleSliderDemo
//
//  Created by linger on 16/1/13.
//  Copyright © 2016年 linger. All rights reserved.
//

#import "ViewController.h"
#import "JLDoubleSlider/JLDoubleSlider.h"
@interface ViewController ()

@end

@implementation ViewController
{
    JLDoubleSlider *_slider;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _slider = [[JLDoubleSlider alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    _slider.unit = @"￥";
    _slider.minNum = 14;
    _slider.maxNum = 59;
    _slider.minTintColor = [UIColor redColor];
    _slider.maxTintColor = [UIColor blueColor];
    _slider.mainTintColor = [UIColor blackColor];
    
    [self.view addSubview:_slider];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [btn setTitle:@"打 印 范围" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onclick
{
    NSLog(@" \n min %f \n max %f",_slider.currentMinValue,_slider.currentMaxValue);
}
@end
