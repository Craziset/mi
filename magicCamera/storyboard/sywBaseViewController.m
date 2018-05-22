//
//  sywBaseViewController.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "sywBaseViewController.h"

@interface sywBaseViewController ()

@end

@implementation sywBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar addSubview:lineView];
    //创建自定义视图
    UIView *leftBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftBtnView.backgroundColor = [UIColor clearColor];
    //加载自定义视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    
    //后退按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 8, 25, 25);
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navClick1) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn];
    
    //关闭按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn.right+20, 8, 25, 25);
    [btn2 setImage:[UIImage imageNamed:@"主页"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(navClick2) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn2];
}
-(void)navClick1{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    [self.navigationController popToViewController:vc animated:YES];
}
-(void)navClick2{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:vc animated:YES];
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
