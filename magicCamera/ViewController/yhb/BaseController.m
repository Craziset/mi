//
//  BaseController.m
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "BaseController.h"
#import "SelectImgController.h"
#import "DrawPicController.h"
#import "SelectKindController.h"
#import "PlaceOrderController.h"
#import <objc/runtime.h>

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",[self.class class]);
    int index=0;
    NSString *class_string = [NSString stringWithFormat:@"%s",class_getName(self.class)];
    if ([class_string isEqualToString:@"SelectImgController"]) {
        index = 0;
    }else if ([class_string isEqualToString:@"DrawPicController"]) {
        index = 1;
    }else if ([class_string isEqualToString:@"SelectKindController"]) {
        index = 2;
    }else if ([class_string isEqualToString:@"PlaceOrderController"]) {
        index = 3;
    }
    NSArray *titleArr = @[@"1.选图",@"2.作图",@"3.选品",@"4.下单"];
    for (int i=0; i<titleArr.count; i++) {
        UILabel *label = [MyBaseView myLabelFrame:CGRectMake(i*Width/4, NAVHEIGHT, Width/4, 40*rateh) text:titleArr[i] textColor:RGB(38, 38, 38) backgroudColor:RGB(240, 240, 240) font:[UIFont systemFontOfSize:15*rateh]];
        label.textAlignment = NSTextAlignmentCenter;
        
//        label.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//        label.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        label.layer.shadowOpacity = 0.15;//阴影透明度，默认0
//        label.layer.shadowRadius = 2;//阴影半径，默认3
        
        
        if (i==index) {
            label.backgroundColor = YEllOWColor;
            label.textColor = [UIColor whiteColor];
        }
        [self.view addSubview:label];
    }
    //下一步
    _nextButton = [MyBaseView myButtonFrame:CGRectMake((Width-170*ratew)/2, Height-49*rateh, 160*ratew, 35*ratew) text:@"下一步" textColor:[UIColor whiteColor] backgroudColor:YEllOWColor font:[UIFont systemFontOfSize:18*rateh]];
    _nextButton.layer.cornerRadius = 6;
    [self.view addSubview:_nextButton];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
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




