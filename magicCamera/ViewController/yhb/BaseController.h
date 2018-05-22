//
//  BaseController.h
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseView.h"
#import "CustomTableView.h"
#import "NetworkRequest.h"
#import "UIImageView+WebCache.h"
/****************************适配*********************************/
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define ratew (Width/375.0)
#define rateh (Height/667.0)
#define CGRect(x,y,width,heigth)  CGRectMake((x)*ratew, (y)*rateh, width*ratew, heigth*rateh)
#define NAVHEIGHT (Height<812.0?64.0:88.0)
/****************************适配*********************************/
/****************************颜色*********************************/
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define RGB(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


@interface BaseController : sywBaseViewController

@property (nonatomic,strong) UIButton *nextButton;//下一步按钮
@property (nonatomic,strong) UITableView *tableview;

@end



