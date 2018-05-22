//
//  XPSFaceBeautify.h
//  XPSFaceBeautify
//
//  Created by 徐征 on 2017/11/2.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface XPSFaceBeautify : NSObject
//边缘淡化模糊
+ (UIImage *)applyGaussianSelectiveBlur:(UIImage *)image;
///美白
+ (UIImage *)whiteningWithImage:(UIImage *)image;
///动画素描
+ (UIImage *)applySketchFilter:(UIImage *)image;

///剪切
+ (UIImage *)cuttingBackgroundImage:(UIImage *)image withInfo:(NSArray *)array;

///过滤背景颜色
+ (UIImage *) imageToFaceHandleImage:(UIImage *) image isTransparent:(BOOL)t;

///美白图片
+ (UIImage *)whiteImage:(UIImage *)image
              Whiteness:(int)whiteness;

@end
