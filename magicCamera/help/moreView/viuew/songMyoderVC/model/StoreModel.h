//
//  StoreModel.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject
/**
 address = "\U91cd\U5e86\U5e02\U5317\U789a\U533a\U4e07\U8fbe\U5e7f\U573a\U4e00\U697cA1007\U7c73\U516d\U7ae5\U88c5";
 "business_time" = "10:00-21:30";
 "customer_service_phone" = 4001108166;
 phone = 18966666601;
 "store_name" = "\U91cd\U5e86\U5317\U789a\U4e07\U8fbe\U5e97";
 */

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *business_time;
@property (nonatomic, copy) NSString *customer_service_phone;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *store_name;

@end
