//
//  CameraViewController.h
//  FaceImage
//
//  Created by 徐征 on 2017/10/30.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCPPSDK.h"
#import "MBProgressHUD.h"


typedef void(^imageBlock)(UIImage *kaimage);
@interface CameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, copy) imageBlock imageblock;
@property (nonatomic,strong) UIImage *image;

@property (nonatomic, strong) UIImage *image_mat;
@property (nonatomic, strong) UIImage *image_face;
@property (nonatomic, strong) UIImage *image_hair;
@property (nonatomic, strong) UIImage *image_facestyle;

@property (nonatomic, assign) CGRect rect_face;
@property (nonatomic, assign) CGRect rect_hair;
@property (nonatomic, assign) CGRect rect_facestyle;


- (void)handleImage:(UIImage *)image;

@end

