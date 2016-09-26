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

@interface NumberView ()

@property (nonatomic, strong) SingleNumberView  *singleNumberOne;
@property (nonatomic, strong) SingleNumberView *singleNumberTwo;
@property (nonatomic, strong) UILabel *milliSecLabel;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) NSTimer *millisecTimer;
@property (nonatomic, assign) NSInteger currentMillsec;

@end

@implementation NumberView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
        
        self.currentMillsec = 99;
    }
    return self;
}

- (void)setTimeSpan:(NSInteger)timeSpan {
    _timeSpan = timeSpan;
}

#pragma mark - about timer
- (void)startTimer {
    self.singleNumberTwo.currentNumber = self.timeSpan % 10;
    self.singleNumberOne.currentNumber = self.timeSpan / 10;
    self.milliSecLabel.text = @"99";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TimeSlice target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.millisecTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(pxy_changeMilliSecAnimation) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.millisecTimer forMode:NSRunLoopCommonModes];
}

/**
 停止计时器
 */
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    
    [self.millisecTimer invalidate];
    self.millisecTimer = nil;
    
    self.milliSecLabel.text = @"00";
}

#pragma mark - private function
- (void)pxy_setupUI {
    self.singleNumberOne = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [self addSubview:self.singleNumberOne];
    self.singleNumberTwo = [[SingleNumberView alloc] initWithFrame:CGRectMake(25, 0, 20, 30)];
    [self addSubview:self.singleNumberTwo];
    
    self.milliSecLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 30, 30)];
    [self addSubview:self.milliSecLabel];
}

/**
 个位秒数变化
 */
- (void)pxy_scrollAnimation {
    
    if (self.timeSpan == 0) {
        [self stopTimer];
        return;
    }
    
    [UIView animateWithDuration:0.9 animations:^{
        self.singleNumberTwo.labelGroupView.frame = CGRectMake(0, -self.singleNumberTwo.frame.size.height, self.singleNumberTwo.frame.size.width, self.singleNumberTwo.frame.size.width);
        
    } completion:^(BOOL finished) {
        
        self.singleNumberTwo.currentNumber --;
        
        if (self.timeSpan % 10  == 0) {
            [self pxy_scrollTenDigitAnimation];
        }
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

- (void)pxy_changeMilliSecAnimation {
    //- todo
    [UIView animateWithDuration:0.008 animations:^{
        self.milliSecLabel.text = [NSString stringWithFormat:@"%02ld", self.currentMillsec];
        if (self.currentMillsec == 0) {
            self.currentMillsec = 99;
        }
    }];
    self.currentMillsec --;
}

@end
