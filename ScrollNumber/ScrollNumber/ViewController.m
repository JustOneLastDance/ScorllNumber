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
    self.numberView = [[NumberView alloc] initWithFrame:CGRectMake(100, 100, 20, 40)];
    [self.view addSubview:self.numberView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

@end
