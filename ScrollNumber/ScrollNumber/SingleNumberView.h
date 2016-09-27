//
//  SingleNumberView.h
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleNumberView : UIView

/**
 label组合
 */
@property (nonatomic, strong) UIView *labelGroupView;

/**
 当前显示的数字
 */
@property (nonatomic, assign) NSInteger currentNumber;

@end
