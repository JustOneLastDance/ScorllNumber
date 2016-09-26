//
//  SingleNumberView.m
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import "SingleNumberView.h"

@interface SingleNumberView ()

@property (nonatomic, strong) UILabel *numberOneLabel;
@property (nonatomic, strong) UILabel *numberTwoLabel;

@end

@implementation SingleNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
    }
    return self;
}

- (void)setCurrentNumber:(NSInteger)currentNumber {
    _currentNumber = currentNumber;
    self.numberOneLabel.text = [NSString stringWithFormat:@"%ld", self.currentNumber];
    self.numberTwoLabel.text = [NSString stringWithFormat:@"%ld", self.currentNumber - 1];
}

- (void)pxy_setupUI {
    
    self.labelGroupView = [[UIView alloc] init];
    self.labelGroupView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2);
    [self addSubview:self.labelGroupView];

    self.numberOneLabel = [[UILabel alloc] init];
    self.numberOneLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.numberOneLabel.backgroundColor = [UIColor yellowColor];
    self.numberOneLabel.textAlignment = NSTextAlignmentCenter;
    self.numberOneLabel.text = @"0";
    self.numberOneLabel.textColor = [UIColor blackColor];
    [self.labelGroupView addSubview:self.numberOneLabel];
    
    self.numberTwoLabel = [[UILabel alloc] init];
    self.numberTwoLabel.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.numberTwoLabel.backgroundColor = [UIColor greenColor];
    self.numberTwoLabel.textAlignment = NSTextAlignmentCenter;
    self.numberTwoLabel.text = @"0";
    self.numberTwoLabel.textColor = [UIColor blackColor];
    [self.labelGroupView addSubview:self.numberTwoLabel];
    
    self.clipsToBounds = true;
}

@end
