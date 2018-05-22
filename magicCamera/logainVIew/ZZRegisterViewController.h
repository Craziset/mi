//
//  ZZRegisterViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/9/29.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZRegisterViewController : XXBaseViewController

@property(nonatomic, strong)NSDictionary* disanfangDic;
@property(nonatomic, copy)void(^loginBlock)(void);
@end
