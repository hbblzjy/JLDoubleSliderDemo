//
//  UIView+Dimension.h
//  JLDoubleSliderDemo
//
//  Created by linger on 16/1/13.
//  Copyright © 2016年 linger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Dimension)

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat centerX;
- (void)changeTopByAdding:(NSNumber *)number;

@end
