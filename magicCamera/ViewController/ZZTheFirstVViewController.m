//
//  ZZTheFirstVViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/9/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZTheFirstVViewController.h"
#import "ZZSelectionImageViewController.h"
#import "ZZLogainViewController.h"
#import "ViewController.h"
#import "ZZpersonviewViewController.h"
#import "SelectImgController.h"
#import "ZZMerchandiseViewController.h"
#import "ZZdesignViewController.h"
#import "ZZLoginViewController.h"
@interface ZZTheFirstVViewController ()
@property (weak, nonatomic) IBOutlet UIButton *firstView_Button;
@property (weak, nonatomic) IBOutlet UIButton *firstView_secondButton;
@property (weak, nonatomic) IBOutlet UIButton *firstView_Third_Button;
@property (weak, nonatomic) IBOutlet UIButton *firstView_Four_Button;
@property (weak, nonatomic) IBOutlet UIButton *firstView_fix_Button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *padConst;

@end

@implementation ZZTheFirstVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (SCR_HEIGHT>1100)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           self.padConst.constant = -120;
        });
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)play_camera_Button:(id)sender {
   /*
    @author:yhb
    reason:由于原工程为写完整，将原来的写法进行替换了
    以前的：ZZSelectionImageViewController *first = [[ZZSelectionImageViewController alloc]init];
    first.index = 0;
    [self.navigationController pushViewController:first animated:YES];
    */
    SelectImgController *selectImgC = [[SelectImgController alloc] init];
    [self.navigationController pushViewController:selectImgC animated:YES];
    
}
- (IBAction)two_Button_camera:(id)sender {

//    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        ViewController *view = [[ViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
//    }else
//    {
//        ZZLoginViewController *loginvc= initVCFromSTBWithIdentifer(@"Login", @"ZZLoginViewController");
//        [self.navigationController pushViewController:loginvc animated:YES];
//    }
}
- (IBAction)threeClickedBtn:(id)sender {  //第三模版：系统素材
    //暂时放在这里是为了进行测试  第三和第四模块是在一起的
    
    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        ZZdesignViewController *per = [[ZZdesignViewController alloc]init];
        per.isType = YES;
        [self.navigationController pushViewController:per animated:YES];
    }else
    {
        ZZLoginViewController *loginvc= initVCFromSTBWithIdentifer(@"Login", @"ZZLoginViewController");
        [self.navigationController pushViewController:loginvc animated:YES];
    }
}

- (IBAction)last_ViewButton:(id)sender {  // 第四模块:个人素材
  
    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        ZZdesignViewController *per = [[ZZdesignViewController alloc]init];
        per.isType = NO;
        [self.navigationController pushViewController:per animated:YES];
    }else
    {
        ZZLoginViewController *loginvc= initVCFromSTBWithIdentifer(@"Login", @"ZZLoginViewController");
        [self.navigationController pushViewController:loginvc animated:YES];
    }
}

- (IBAction)songLastBtnEventsong:(id)sender {
 //  第五模块：个人画室
    //判断用户是否登录
    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        ZZpersonviewViewController *per = [[ZZpersonviewViewController alloc]init];
        [self.navigationController pushViewController:per animated:YES];
    }else
    {
        ZZLoginViewController *loginvc= initVCFromSTBWithIdentifer(@"Login", @"ZZLoginViewController");
        [self.navigationController pushViewController:loginvc animated:YES];
    }
    
}


@end
