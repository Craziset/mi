//
//  ZZUserManager.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZUserModel;

@interface ZZUserManager : NSObject

@property (nonatomic, strong) NSNumber *isLogin;

@property (nonatomic, strong) ZZUserModel *userModel;

+ (ZZUserManager *)shareManager;

- (void)saveUser:(ZZUserModel *)user;

- (ZZUserModel *)userManager;

- (BOOL)deleteUser;


@end
