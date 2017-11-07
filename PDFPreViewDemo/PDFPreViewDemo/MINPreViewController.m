//
//  MINPreViewController.m
//  PDFPreViewDemo
//
//  Created by yangdeming on 2017/11/7.
//  Copyright © 2017年 yangdeming. All rights reserved.
//

#import "MINPreViewController.h"
#import <QuickLook/QuickLook.h>

@interface MINPreViewController () <QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@end

@implementation MINPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //先给背景色，会事先创建控制器，尤其在tabbar根控制器中，有很多显示问题可以避免
    self.view.backgroundColor = [UIColor whiteColor];
    
    //控制当前控制器对应的导航条显示的内容
    self.navigationItem.title=@"预览";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.frame = CGRectMake(0, 0, 20, 44);
    [backButton setImage:[UIImage imageNamed:@"btnBack_black"] forState:UIControlStateNormal];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    /// 原理是使用自定义控制器，加载QLPreviewController的view，比较方便灵活
    if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)self.myUrl]) {
        
        QLPreviewController* previewer = [[QLPreviewController alloc] init];
        previewer.dataSource = self;
        previewer.delegate = self;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        previewer.view.frame = CGRectMake(0, 64, width, height-64);
        [self.view addSubview:previewer.view];
        NSString *version = [UIDevice currentDevice].systemVersion;
        /// 在iOS10以下 使用didMove方法 10开始没有效果
        if (version.floatValue >= 10.0) {
            [self addChildViewController:previewer];
        } else {
            [previewer didMoveToParentViewController:self];
        }
    }
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 返回加载文件个数
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}
#pragma mark --- 返回加载路径
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.myUrl;
}

@end
