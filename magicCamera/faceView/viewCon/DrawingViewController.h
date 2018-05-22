//
//  DrawingViewController.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/8.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "XXBaseViewController.h"

@interface DrawingViewController : XXBaseViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImage *image_mat;
@property (nonatomic, strong) UIImage *image_face;
@property (nonatomic, strong) UIImage *image_hair;
@property (nonatomic, strong) UIImage *image_facestyle;

@property (nonatomic, assign) CGRect rect_face;
@property (nonatomic, assign) CGRect rect_hair;
@property (nonatomic, assign) CGRect rect_facestyle;






@end
