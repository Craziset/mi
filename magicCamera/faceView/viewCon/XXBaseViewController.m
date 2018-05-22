//
//  XXBaseViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/21.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "XXBaseViewController.h"
#import "CustomNavigationBar.h"
#import "UIBarButtonItem+SXCreate.h"

@interface XXBaseViewController ()

@end

@implementation XXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *leftSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    leftSpaceBarButtonItem.width = -20;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar addSubview:lineView];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickLeftItemA) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:backBtn];
    
    UIButton *homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 40, 40)];
    [homeBtn setImage:[UIImage imageNamed:@"主页"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(clickLeftItemB) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:homeBtn];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}  
- (void)clickLeftItemA
{
    if (!self.secondStep) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)clickLeftItemB
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
