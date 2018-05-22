//
//  SelectImgController.m
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "SelectImgController.h"
#import "DrawPicController.h"
#import "ZJProgressHUD.h"
@interface SelectImgController ()
{
    UIImageView *backImageView;
    NSArray *titleArr;//分类
    NSArray *boardImgArr;//画板背景图列表
    NSInteger select_index;
    CustomTableView *tablev1;
    CustomTableView *tablev2;
}

@end

@implementation SelectImgController

//下一步
-(void)nextBtn:(UIButton *)button{
    DrawPicController *drawC = [[DrawPicController alloc] init];
    drawC.selectImage = backImageView.image;
    [self.navigationController pushViewController:drawC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //下一步点击事件
    [self.nextButton addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    //设置图片展示
    backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+40*rateh, Width, Height-NAVHEIGHT-40*rateh-170*rateh)];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    //创建tableview
    tablev1 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, Height-160*rateh, Width, 30*rateh) result:^(id result) {
        NSLog(@"%@",result);
        [tablev2 setBoardImgArr:result[@"tag_data"]];
    }];
    [self.view addSubview:tablev1];
    //创建tableview
    tablev2 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, Height-130*rateh, Width, 70*rateh) result:^(id result) {
        NSLog(@"%@",result);
        NSURL *original_path = [NSURL URLWithString:result[@"original_image"]];
        [backImageView sd_setImageWithURL:original_path placeholderImage:[UIImage imageNamed:@"common_nopic"]];
    }];
    [self.view addSubview:tablev2];
    //获取背景图
    [self getDrawbackImageView];
}
#pragma mark - 请求画板背景图列表
-(void)getDrawbackImageView{
    [ZJProgressHUD showProgress];
    [NetworkRequest requestWithApi:MgetSource Params:nil type:@"POST" withBlock:^(id responseObject) {
        [ZJProgressHUD hideAllHUDs];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
                if ([responseObject[@"result"] [@"data"] isKindOfClass:[NSArray class]]) {
                    titleArr = responseObject[@"result"] [@"data"];
                }
            }
        }
        [tablev1 setTitleArr:titleArr];
    }];
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
