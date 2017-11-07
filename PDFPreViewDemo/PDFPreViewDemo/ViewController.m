//
//  ViewController.m
//  PDFPreViewDemo
//
//  Created by yangdeming on 2017/11/7.
//  Copyright © 2017年 yangdeming. All rights reserved.
//

#import "ViewController.h"
#import "MINPreViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 200, self.view.bounds.size.width, 44);
    [button setTitle:@"查看文件" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor cyanColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)buttonClick:(UIButton *)button {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minge.pdf" ofType: nil];
    NSURL *pathUrl = [NSURL fileURLWithPath:path];
    MINPreViewController *preVC = [MINPreViewController new];
    preVC.myUrl = pathUrl;
    [self.navigationController pushViewController:preVC animated:YES];
}

@end
