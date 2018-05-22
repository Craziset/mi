//
//  WorkViewController.h
//  FaceImage
//
//  Created by 徐征 on 2017/10/25.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCBaseViewController.h"

typedef void(^imageBlock)(UIImage *image);
@interface WorkViewController : FCBaseViewController

@property (nonatomic, copy) imageBlock block;

@end
