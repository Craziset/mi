//
//  WorkViewController.m
//  FaceImage
//
//  Created by 徐征 on 2017/10/25.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "WorkViewController.h"
#import "MBProgressHUD.h"
#import "UIImage+FCExtension.h"
#import "XPSFaceBeautify.h"

@interface WorkViewController ()
{
    CGFloat angle1;
}
@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"renlian.png"];
    //
//    image = [XPSFaceBeautify whiteningWithImage:image];
    
    [self.imageView setImage:image];

    
    CGFloat h = self.view.bounds.size.height;
    CGFloat w = self.view.bounds.size.width;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, h-100, w - 40, 40)];
    [button setTitle:@"识别并剪裁面部" forState:(UIControlStateNormal)];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)clickButton:(UIButton *)button {
    [self handleImage:self.imageView.image];
}

- (void)handleImage:(UIImage *)image{
    
    
    //清除人脸框
    [self.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //检测人脸
    FCPPFaceDetect *faceDetect = [[FCPPFaceDetect alloc] initWithImage:image];
    self.imageView.image = faceDetect.image;
    self.image = faceDetect.image;
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //需要获取的属性
    NSArray *att = @[@"gender",@"age",@"headpose",@"smiling",@"blur",@"eyestatus",@"emotion",@"facequality",@"ethnicity"];
    [faceDetect detectFaceWithReturnLandmark:YES attributes:att completion:^(id info, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        weakSelf.tableView.contentOffset = CGPointMake(0, -64);
        [weakSelf.dataArray removeAllObjects];
        
        if (info) {
            NSArray *array = info[@"faces"];
            if (array.count) {
                UIImage *image = faceDetect.image;
                
                //绘制关键点和矩形框
                [weakSelf handleImage:image withInfo:array];
                
                //显示每个人脸的详细信息
                [weakSelf.dataArray addObjectsFromArray:array];
                //显示json
                [weakSelf showResult:info];
            }else{
                [weakSelf showContent:@"没有检测到人脸"];
            }
        }else{
            [weakSelf showError:error];
            [weakSelf handleImage:image];
        }
        [weakSelf.tableView reloadData];
    }];
    
}

- (void)handleImage:(UIImage *)image withInfo:(NSArray *)array{
    
//    CGFloat scaleH = self.imageView.bounds.size.width / image.size.width;
//    CGFloat scaleV = self.imageView.bounds.size.height / image.size.height;
//    CGFloat scale = scaleH < scaleV ? scaleH : scaleV;
//    CGFloat offsetX = image.size.width*(scaleH - scale)*0.5;
//    CGFloat offsetY = image.size.height*(scaleV - scale)*0.5;
//
//    //绘制矩形框
//    for (NSDictionary *dic in array) {
//        NSDictionary *rect = dic[@"face_rectangle"];
//        CGFloat angle = [dic[@"attributes"][@"headpose"][@"roll_angle"] floatValue];
//
//        CGFloat x = [rect[@"left"] floatValue];
//        CGFloat y = [rect[@"top"] floatValue];
//        CGFloat w = [rect[@"width"] floatValue];
//        CGFloat h = [rect[@"height"] floatValue];
//
//        UIView *rectView = [[UIView alloc] initWithFrame:CGRectMake(x*scale+offsetX, y*scale+offsetY, w*scale, h*scale)];
//        rectView.transform = CGAffineTransformMakeRotation(angle/360.0 *2*M_PI);
//        rectView.layer.borderColor = [UIColor greenColor].CGColor;
//        rectView.layer.borderWidth = 1;
//
//        [self.imageView addSubview:rectView];
//
////        [self.image cropWithRect:CGRectMake(x, y, w, h)];
//    }
    
    
//    image =  [XPSFaceBeautify applySketchFilter:image];
    
    image = [XPSFaceBeautify cuttingBackgroundImage:image withInfo:array];
    
    self.imageView.image = image;
    if (self.block) {
        self.block(self.imageView.image);
        [self.navigationController popViewControllerAnimated:YES];
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

