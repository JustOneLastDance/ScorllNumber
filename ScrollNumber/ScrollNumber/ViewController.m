//
//  ViewController.m
//  ScrollNumber
//
//  Created by JustinChou on 16/9/26.
//  Copyright © 2016年 JustinChou. All rights reserved.
//

#import "ViewController.h"
#import "NumberView.h"

@interface ViewController ()
@property (nonatomic, strong) NumberView *numberView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.numberView = [[NumberView alloc] initWithFrame:CGRectMake(10, 50, 339, 99)];
    [self.view addSubview:self.numberView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.numberView.timeSpan = 29;
    [self.numberView startTimer];
    
}

@end
