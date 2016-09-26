//
//  NumberView.m
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import "NumberView.h"
#import "SingleNumberView.h"

@interface NumberView ()


@property (nonatomic, strong) SingleNumberView  *singleNumberOne;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation NumberView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
        
    }
    return self;
}

- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)pxy_setupUI {
    self.backgroundColor = [UIColor blackColor];
    self.singleNumberOne = [[SingleNumberView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    self.singleNumberOne.currentNumber = 9;
    [self addSubview:_singleNumberOne];
}

- (void)pxy_scrollAnimation {
    
    if (self.singleNumberOne.currentNumber == 0) {
        self.singleNumberOne.currentNumber = 9;
    }
    
    NSLog(@"doing animation");
    [UIView animateWithDuration:0.9 animations:^{
        self.singleNumberOne.labelGroupView.frame = CGRectMake(0, -self.singleNumberOne.frame.size.height, self.singleNumberOne.frame.size.width, self.singleNumberOne.frame.size.width);
    } completion:^(BOOL finished) {
        self.singleNumberOne.currentNumber --;
        self.singleNumberOne.labelGroupView.frame = CGRectMake(0, 0, self.singleNumberOne.frame.size.width, self.singleNumberOne.frame.size.width);
    }];
}

@end
