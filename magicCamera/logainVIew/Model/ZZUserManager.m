//
//  ZZUserManager.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZUserManager.h"

#define AccountPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"user.archive"]

@interface ZZUserManager()
{
    NSNumber *_isLogin;
}
@end

@implementation ZZUserManager

+ (ZZUserManager *)shareManager
{
    static ZZUserManager *manager;
    static dispatch_once_t onceToken;
    if (!manager) {
        dispatch_once(&onceToken, ^{
            manager = [[ZZUserManager alloc]init];
        });
    }
    return manager;
}

- (void)saveUser:(ZZUserModel *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:AccountPath];
}

- (ZZUserModel *)userManager{
    ZZUserModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    return account;
}

- (BOOL)deleteUser{
    return [[NSFileManager defaultManager]removeItemAtPath:AccountPath error:nil];
}


- (NSNumber *)isLogin
{
    if (!_isLogin) {
        _isLogin = [[NSUserDefaults standardUserDefaults]valueForKey:ISLOGIN]?[[NSUserDefaults standardUserDefaults]valueForKey:ISLOGIN]:@NO;
    }
    return _isLogin;
}

- (void)setIsLogin:(NSNumber *)isLogin {
    _isLogin = isLogin;
    [[NSUserDefaults standardUserDefaults]setObject:isLogin forKey:ISLOGIN];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
