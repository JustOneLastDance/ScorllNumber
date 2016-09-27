//
//  NumberView.h
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberView : UIView

/**
 倒计时时间
 */
@property (nonatomic, assign) NSInteger timeSpan;
/**
 开始计时器，数字降为0时自动停止
 */
- (void)startTimer;

@end
