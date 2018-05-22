//
//  ZZUserModel.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUserModel : NSObject
/**
 avatar = "http://diy.cnmi6.com/images/Default_avatar.png";
 "is_official" = 0;
 "is_store" = 0;
 "nick_name" = "152****9722";
 "original_avatar" = "http://diy.cnmi6.com/images/original_Default_avatar.png";
 "store_name" = "";
 "store_phone" = "";
 "store_store_id" = "";
 "store_user_id" = "";
 "user_id" = 11133;
 "user_type" = 0;

 */

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *is_official;
@property (nonatomic, copy) NSString *is_store;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, copy) NSString *original_avatar;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *store_phone;
@property (nonatomic, copy) NSString *store_store_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, copy) NSString *user_type;

@end
