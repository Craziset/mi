//
//  XXCouponModel.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/29.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXCouponModel : NSObject
/**
 "begin_time" = 1511884800;
 "binding_type" = 1;
 "channel_id" = A999;
 "coupon_id" = A9992YSR1924;
 "coupon_type" = 2;
 desc = "\U6d4b\U8bd5\U4e13\U7528";
 "end_time" = 1511971199;
 name = "\U6d4b\U8bd5";
 price = "300.00";
 state = 1;
 "time_str" = "2017.11.29\U81f32017.11.29";
 "user_id" = 11112;
 "using_time" = 0;
 */

@property (nonatomic, copy) NSString *begin_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *binding_type;
@property (nonatomic, copy) NSString *channel_id;
@property (nonatomic, copy) NSString *coupon_id;
@property (nonatomic, copy) NSString *coupon_type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *using_time;

@end
