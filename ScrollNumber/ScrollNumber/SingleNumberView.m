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

#pragma mark - initial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pxy_setupUI];
    }
    return self;
}

#pragma mark - getter & setter
- (void)setCurrentNumber:(NSInteger)currentNumber {
    _currentNumber = currentNumber;
    self.numberOneLabel.text = [NSString stringWithFormat:@"%ld", self.currentNumber];
    self.numberTwoLabel.text = [NSString stringWithFormat:@"%ld", self.currentNumber - 1];
    
    // ******* 头尾 0 和 9 的自然衔接方式 ********
    if (currentNumber == 0) {
        self.numberTwoLabel.text = [NSString stringWithFormat:@"%d", 9];
    }
}


#pragma mark - private function
- (void)pxy_setupUI {
    
    [self layoutIfNeeded];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"countdown_brand"]];
    self.labelGroupView = [[UIView alloc] init];
    self.labelGroupView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2);
    [self addSubview:self.labelGroupView];

    self.numberOneLabel = [[UILabel alloc] init];
    self.numberOneLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.numberOneLabel.backgroundColor = [UIColor clearColor];
    self.numberOneLabel.textAlignment = NSTextAlignmentCenter;
    self.numberOneLabel.text = @"0";
    self.numberOneLabel.textColor = [UIColor whiteColor];
    [self.numberOneLabel setFont:[UIFont systemFontOfSize:40]];
    [self.labelGroupView addSubview:self.numberOneLabel];
    
    self.numberTwoLabel = [[UILabel alloc] init];
    self.numberTwoLabel.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.numberTwoLabel.backgroundColor = [UIColor clearColor];
    self.numberTwoLabel.textAlignment = NSTextAlignmentCenter;
    self.numberTwoLabel.text = @"0";
    self.numberTwoLabel.textColor = [UIColor whiteColor];
    [self.numberTwoLabel setFont:[UIFont systemFontOfSize:40]];
    [self.labelGroupView addSubview:self.numberTwoLabel];
    
    self.clipsToBounds = true;
}

@end
