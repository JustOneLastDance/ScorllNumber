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

@end

@implementation NumberView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
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
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:TimeSlice target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - private function
- (void)pxy_setupUI {
    self.singleNumberOne = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [self addSubview:self.singleNumberOne];
    self.singleNumberTwo = [[SingleNumberView alloc] initWithFrame:CGRectMake(25, 0, 20, 30)];
    [self addSubview:self.singleNumberTwo];
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

@end
