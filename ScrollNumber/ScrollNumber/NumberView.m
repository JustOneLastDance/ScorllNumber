//
//  NumberView.m
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import "NumberView.h"
#import "SingleNumberView.h"

#define TimeSlice 1.0
#define CountdownBrand_Width 39
#define CountdownBrand_Height 64

@interface NumberView ()

@property (nonatomic, strong) SingleNumberView *singleNumberOne;
@property (nonatomic, strong) SingleNumberView *singleNumberTwo;

@property (nonatomic, strong) SingleNumberView *hundredMilliSecView;
@property (nonatomic, strong) SingleNumberView *tenMilliSecView;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) NSTimer *millisecTimer;

@end

@implementation NumberView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
    }
    return self;
}

#pragma mark - getter & setter
- (void)setTimeSpan:(NSInteger)timeSpan {
    _timeSpan = timeSpan;
}

#pragma mark - about timer
- (void)startTimer {
    self.singleNumberTwo.currentNumber = self.timeSpan % 10;
    self.singleNumberOne.currentNumber = self.timeSpan / 10;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TimeSlice target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.millisecTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(pxy_changeMilliSecAnimation) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.millisecTimer forMode:NSRunLoopCommonModes];
}

/**
 停止计时器
 */
- (void)stopTimer {
    [self.millisecTimer invalidate];
    self.millisecTimer = nil;
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.tenMilliSecView.currentNumber = 0;
    self.hundredMilliSecView.currentNumber = 0;
    
}

#pragma mark - private function
- (void)pxy_setupUI {
    
    [self layoutIfNeeded];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"countdown_background"]];
    bgImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:bgImgView];
    
    CGFloat bg_center_y = self.frame.size.height * 0.5 - 5;
    CGFloat bg_center_x = self.frame.size.width * 0.5;
    
    self.singleNumberOne = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    self.singleNumberOne.center = CGPointMake(bg_center_x - CountdownBrand_Width * 0.5, bg_center_y);
    [self addSubview:self.singleNumberOne];
    
    self.singleNumberTwo = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    self.singleNumberTwo.center = CGPointMake(bg_center_x + CountdownBrand_Width * 0.5, bg_center_y);
    [self addSubview:self.singleNumberTwo];

    SingleNumberView *tempOneView = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    tempOneView.center = CGPointMake(bg_center_x - CountdownBrand_Width * 0.5 * 3 - 10, bg_center_y);
    [self addSubview:tempOneView];

    SingleNumberView *tempTwoView = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    tempTwoView.center = CGPointMake(bg_center_x - CountdownBrand_Width * 0.5 * 5 - 10, bg_center_y);
    [self addSubview:tempTwoView];
    
    self.hundredMilliSecView = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    self.hundredMilliSecView.center = CGPointMake(bg_center_x + CountdownBrand_Width * 0.5 * 3 + 10, bg_center_y);
    [self addSubview:self.hundredMilliSecView];
    
    self.tenMilliSecView = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, CountdownBrand_Width, CountdownBrand_Height)];
    self.tenMilliSecView.center = CGPointMake(bg_center_x + CountdownBrand_Width * 0.5 * 5 + 10, bg_center_y);
    [self addSubview:self.tenMilliSecView];
    
}

/**
 个位秒数变化
 */
- (void)pxy_scrollAnimation {
    
    if (self.timeSpan == 0) {
        [self stopTimer];
        return;
    }
    
    if (self.timeSpan % 10  == 0) {
        [self pxy_scrollTenDigitAnimation];
    }
    
    [UIView animateWithDuration:0.9 animations:^{
        self.singleNumberTwo.labelGroupView.frame = CGRectMake(0, -self.singleNumberTwo.frame.size.height, self.singleNumberTwo.frame.size.width, self.singleNumberTwo.frame.size.width);
        
    } completion:^(BOOL finished) {
        
        self.singleNumberTwo.currentNumber --;
        
//        if (self.timeSpan % 10  == 0) {
//            [self pxy_scrollTenDigitAnimation];
//        }
        
        self.singleNumberTwo.currentNumber = self.timeSpan % 10;
        
        self.singleNumberTwo.labelGroupView.frame = CGRectMake(0, 0, self.singleNumberTwo.frame.size.width, self.singleNumberTwo.frame.size.width);
        
    }];
    
    self.timeSpan --;
    NSLog(@"%ld",self.timeSpan);
}


/**
 十位秒数变化
 */
- (void)pxy_scrollTenDigitAnimation {
    NSLog(@"10S animation");
    
    if (self.timeSpan == 0) {
        return;
    }
    
    [UIView animateWithDuration:0.9 animations:^{
        self.singleNumberOne.labelGroupView.frame = self.singleNumberOne.labelGroupView.frame = CGRectMake(0, -self.singleNumberOne.frame.size.height, self.singleNumberOne.frame.size.width, self.singleNumberOne.frame.size.width);
    } completion:^(BOOL finished) {
        
        self.singleNumberOne.currentNumber --;
        self.singleNumberOne.labelGroupView.frame = CGRectMake(0, 0, self.singleNumberOne.frame.size.width, self.singleNumberOne.frame.size.width);
    }];
}

/**
 十毫秒变化（仅仅文本变化）
 */
- (void)pxy_changeMilliSecAnimation {
    [UIView animateWithDuration:0.008 animations:^{
        
        if (self.tenMilliSecView.currentNumber == 0) {
            self.tenMilliSecView.currentNumber = 9;
            [self pxy_scrollHundredMilliSecAnimation];
        }
        self.tenMilliSecView.currentNumber --;
        
    }];
}

/**
 百毫秒变化（滚动方式）
 */
- (void)pxy_scrollHundredMilliSecAnimation {
    [UIView animateWithDuration:0.08 animations:^{
        self.hundredMilliSecView.labelGroupView.frame = self.hundredMilliSecView.labelGroupView.frame = CGRectMake(0, -self.hundredMilliSecView.frame.size.height, self.hundredMilliSecView.frame.size.width, self.singleNumberOne.frame.size.width);
    } completion:^(BOOL finished) {
        
        if (self.hundredMilliSecView.currentNumber == 0) {
            self.hundredMilliSecView.currentNumber = 9;
        }
        self.hundredMilliSecView.currentNumber --;
        self.hundredMilliSecView.labelGroupView.frame = CGRectMake(0, 0, self.hundredMilliSecView.frame.size.width, self.hundredMilliSecView.frame.size.width);
    }];
}

@end
