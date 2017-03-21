//
//  JLDoubleSlider.m
//  JLDoubleSliderDemo
//
//  Created by linger on 16/1/13.
//  Copyright © 2016年 linger. All rights reserved.
//

#import "JLDoubleSlider.h"
#import "UIView+Dimension.h"
static const CGFloat sliderOffY = 50.0f;
@interface JLDoubleSlider ()

@property (nonatomic,assign)CGFloat CurrentMinNum;

@property (nonatomic,assign)CGFloat CurrentMaxNum;

@end

@implementation JLDoubleSlider

{
    
    UIView *_minSliderLine;
    UIView *_maxSliderLine;
    UIView *_mainSliderLine;
    
    
    CGFloat _constOffY;
    
    CGFloat _tatol;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        if (frame.size.height < 80.0f) {
            self.height = 80.0f;
        }
        [self createMainView];
    }
    return self;
}

- (void)createMainView
{
    _minLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width/2.0f, 40)];
    _maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2.0f, 10 ,self.width/2.0f , 40)];
    _minLabel.textAlignment = NSTextAlignmentLeft;
    _maxLabel.textAlignment = NSTextAlignmentRight;
    _minLabel.adjustsFontSizeToFitWidth = YES;
    _maxLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_minLabel];
    [self addSubview:_maxLabel];
    
    self.minNum = 0.0;
    self.maxNum = 0.0;
    self.unit = @"";
    
    _mainSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10,sliderOffY + 20 - 2/2, self.width-20, 2)];
    _mainSliderLine.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_mainSliderLine];
    
    _minSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10, _mainSliderLine.top, 0, _mainSliderLine.height)];
    _minSliderLine.backgroundColor = [UIColor redColor];
    [self addSubview:_minSliderLine];
    
    _maxSliderLine = [[UIView alloc]initWithFrame:CGRectMake(self.width-10, _mainSliderLine.top, 0, _mainSliderLine.height)];
    _maxSliderLine.backgroundColor = [UIColor redColor];
    [self addSubview:_maxSliderLine];
    
    UIButton *minSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(0,sliderOffY + 10, 20, 20)];
    minSliderButton.backgroundColor = [UIColor whiteColor];
    minSliderButton.showsTouchWhenHighlighted = YES;
    minSliderButton.layer.cornerRadius = minSliderButton.width/2.0f;
    minSliderButton.layer.masksToBounds = YES;
    minSliderButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    minSliderButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *minSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMinSliderButton:)];
    [minSliderButton addGestureRecognizer:minSliderButtonPanGestureRecognizer];
    [self addSubview:minSliderButton];
    _minSlider = minSliderButton;
    
    
    UIButton *maxSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width-20, sliderOffY + 10, 20, 20)];
    maxSliderButton.backgroundColor = [UIColor whiteColor];
    maxSliderButton.showsTouchWhenHighlighted = YES;
    maxSliderButton.layer.cornerRadius = minSliderButton.width/2.0f;
    maxSliderButton.layer.masksToBounds = YES;
    maxSliderButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    maxSliderButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *maxSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMaxSliderButton:)];
    [maxSliderButton addGestureRecognizer:maxSliderButtonPanGestureRecognizer];
    [self addSubview:maxSliderButton];
    _maxSlider = maxSliderButton;
    _constOffY = _minSlider.centerY;
    
    
}

- (void)panMinSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.centerY = _constOffY;
    
    
    if (pgr.view.right > _maxSlider.left) {
        pgr.view.right = _maxSlider.left;
    }else{
        if (pgr.view.centerX < 10) {
            pgr.view.centerX = 10;
        }
        if (pgr.view.centerX > self.width-10) {
            pgr.view.centerX = self.width-10;
        }
    }
    _minSliderLine.frame = CGRectMake(_minSliderLine.left, _minSliderLine.top,  pgr.view.centerX-_minSliderLine.left, _minSliderLine.height);
    [self valueMinChange:pgr.view.right];
}

- (void)panMaxSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.centerY = _constOffY;
    
    if (pgr.view.left < _minSlider.right) {
        pgr.view.left = _minSlider.right;
    }else{
        if (pgr.view.centerX < 10) {
            pgr.view.centerX = 10;
        }
        if (pgr.view.centerX > self.width-10) {
            pgr.view.centerX = self.width-10;
        }
    }
    _maxSliderLine.frame = CGRectMake(pgr.view.centerX, _maxSliderLine.top, self.width-pgr.view.centerX-10, _maxSliderLine.height);
    [self valueMaxChange:pgr.view.left];
}

- (void)valueMinChange:(CGFloat)num
{
    _minLabel.text = [NSString stringWithFormat:@"%.3f%@",_minNum + (_tatol * (num-20.0)),_unit];
    _currentMinValue = _minNum + (_tatol * (num-20.0));
}

- (void)valueMaxChange:(CGFloat)num
{
    _maxLabel.text = [NSString stringWithFormat:@"%.3f%@",_minNum +(_tatol * (num-20.0)),_unit];
    _currentMaxValue = _minNum +(_tatol * (num-20.0));
    
}


-(void)setMinNum:(CGFloat)minNum
{
    _minNum = minNum;
    _tatol = (_maxNum - _minNum)/(self.width - 40.0f);
    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    
    _minLabel.text = [NSString stringWithFormat:@"%.3f%@",minNum,_unit];
    _currentMinValue = minNum;
}

-(void)setMaxNum:(CGFloat)maxNum
{
    _maxNum = maxNum;
    _tatol = (_maxNum - _minNum)/(self.width - 40.0f);
    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    _maxLabel.text = [NSString stringWithFormat:@"%.3f%@",maxNum,_unit];
    _currentMaxValue = maxNum;
}



-(void)setMinTintColor:(UIColor *)minTintColor
{
    _minTintColor = minTintColor;
    _minSliderLine.backgroundColor = minTintColor;
}

-(void)setMaxTintColor:(UIColor *)maxTintColor
{
    _maxTintColor = maxTintColor;
    _maxSliderLine.backgroundColor = maxTintColor;
}

-(void)setMainTintColor:(UIColor *)mainTintColor
{
    _mainTintColor = mainTintColor;
    _mainSliderLine.backgroundColor = mainTintColor;
}

-(void)setUnit:(NSString *)unit
{
    _unit = unit;
}


@end
