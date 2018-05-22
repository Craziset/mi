//
//  MBProgressHUD+XPS.h
//  XinShun
//
//  Created by Corepass on 16/12/2.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import "MBProgressHUD.h"

@interface MBProgressHUD (XPS)


+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

/**
 *  显示 HUD
 *
 *  @return 返回一个 MBProgressHud 对象
 */
+ (MBProgressHUD *)showHUD;

/**
 *  隐藏 HUD
 */
+ (void)dissmiss;
@end
