//
//  SelectKindController.m
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "SelectKindController.h"

@interface SelectKindController ()

@end

@implementation SelectKindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置图片展示
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,NAVHEIGHT+40*rateh, Width, Height-NAVHEIGHT-40*rateh-160*rateh)];
    backImageView.image = _selectImage;
    backImageView.userInteractionEnabled = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    
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
