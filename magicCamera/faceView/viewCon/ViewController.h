//
//  ViewController.h
//  FaceImage
//
//  Created by 徐征 on 2017/10/25.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "XXBaseViewController.h"


typedef enum : NSUInteger {
    vcTypeA,
    vcTypeB,
} vcType;

@interface ViewController :XXBaseViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *hairstyleImageV;
@property (nonatomic, strong) UIImageView *faceStyleImageV;


@end

