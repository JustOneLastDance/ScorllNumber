//
//  NumberView.m
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import "NumberView.h"

@interface NumberView ()

@property (nonatomic, strong) UILabel *numberOneLabel;
@property (nonatomic, strong) UILabel *numberTwoLabel;
@property (nonatomic, strong) UIView *labelGroupView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger number;

@end

@implementation NumberView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
        
        self.number = 10;
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
        self.timer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(pxy_scrollAnimation) userInfo:nil repeats:true];
//    self.timer = timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//
//}

- (void)pxy_setupUI {
    
    self.labelGroupView = [[UIView alloc] init];
    self.labelGroupView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2);
    self.labelGroupView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.labelGroupView];
    
    self.numberOneLabel = [[UILabel alloc] init];
    self.numberOneLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.numberOneLabel.backgroundColor = [UIColor yellowColor];
    [self.labelGroupView addSubview:self.numberOneLabel];
    
    self.numberTwoLabel = [[UILabel alloc] init];
    self.numberTwoLabel.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.numberTwoLabel.backgroundColor = [UIColor greenColor];
    [self.labelGroupView addSubview:self.numberTwoLabel];
    
    self.numberOneLabel.text = [NSString stringWithFormat:@"%ld", self.number];
    self.numberTwoLabel.text = [NSString stringWithFormat:@"%ld", self.number - 1];
    
    self.clipsToBounds = true;
}

- (void)pxy_scrollAnimation {
    
    if (self.number == 10) {
        [self.timer invalidate];
        return;
    }
    
    [UIView animateWithDuration:0.9 animations:^{
        self.labelGroupView.frame = CGRectMake(0, - self.frame.size.height, self.frame.size.width, self.frame.size.height * 2);
    } completion:^(BOOL finished) {
        self.number --;
        self.labelGroupView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2);
        self.numberOneLabel.text = [NSString stringWithFormat:@"%ld", self.number];
        self.numberTwoLabel.text = [NSString stringWithFormat:@"%ld", self.number - 1];
    }];
}

@end
