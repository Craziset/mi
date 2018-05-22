//
//  SongHeadmodel.h
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperOrderModel.h"
#import "SongOrderTablemodel.h"
#import "StoreModel.h"
@interface SongHeadmodel :SuperOrderModel


/**
 {
 
 goods =                 {
 vaild =                     (
 {
 "brand_name" = "\U7c736";
 "colour_name" = "\U6df1\U84dd";
 gift =                             (
 );
 "has_preferential" = 0;
 lists =                             (
 );
 "order_detail_number" = 1205;
 "original_image" =                             (
 "http://diy.cnmi6.com/images/product_images/201711/a52cb556e5df2c785d2f33ba669ff11e.jpg"
 );
 "original_price" = 209;
 "preferential_price" = 209;
 "product_id" = 2017111910151495;
 "product_temp_name" = "\U7537\U7ae5\U77ed\U88e4FM7213008";
 quantity = 1;
 "size_name" = 110;
 sku = FM72130082400110;
 thumbnail =                             (
 "http://diy.cnmi6.com/images/product_images/201711/a52cb556e5df2c785d2f33ba669ff11e.jpg"
 );
 }
 );
 };
 
 
 store =                 {
 address = "\U91cd\U5e86\U5e02\U5317\U789a\U533a\U4e07\U8fbe\U5e7f\U573a\U4e00\U697cA1007\U7c73\U516d\U7ae5\U88c5";
 "business_time" = "10:00-21:30";
 "customer_service_phone" = 4001108166;
 phone = 18966666601;
 "store_name" = "\U91cd\U5e86\U5317\U789a\U4e07\U8fbe\U5e97";
 };
 
 {
 "after_str" = "";
 "buyer_id" = 11112;        //购买者id
 "can_aftermark" = 1;         //可以_售后
 "enabled_worksheet" = 1;       //启用/能_工作表
 "good_total_quantity" = 1;     //商品总数量
 
 是售后"is_aftermark" = 0;
 是取消 "is_cancel" = 0;
 是关闭 "is_close" = 0;
 订单之后id "order_after_id" = "";
 订单id  "order_id" = 2017112599561021;
 类型 "send_type" = 1;
 状态 state = 4;
 状态string "state_str" = "\U5df2\U5b8c\U6210\U8ba2\U5355";
 商店 store =             {
 地址address = "\U798f\U5efa\U7701\U6cc9\U5dde\U5e02\U53f0\U5546\U629


 }
 
 */



//@property(nonatomic,copy)NSString *OderNumberLab;
//
//@property(nonatomic,copy)NSString *OderTimeLab;

/*
 "after_str" = "";
 "buyer_id" = 11112;
 "can_aftermark" = 0;
 "enabled_worksheet" = 1;
 "good_total_quantity" = 1;
 
 "is_aftermark" = 0;
 "is_cancel" = 0;
 "is_close" = 0;
 "order_after_id" = "";
 "order_id" = 2017111952101555;
 "send_type" = 2;
 state = 2;
 "state_str" = "\U5f85\U53d1\U8d27\U8ba2\U5355";
 
 "store_id" = 2017081056551011;
 "total_fee" = 209;
 "total_postage" = 0;
 "total_price" = 209;
 "worksheet_id" = "";
 */
@property (nonatomic, copy) NSString *after_str;
@property (nonatomic, copy) NSString *buyer_id;
@property (nonatomic, copy) NSString *can_aftermark;
@property (nonatomic, copy) NSString *enabled_worksheet;
@property (nonatomic, copy) NSString *good_total_quantity;

@property (nonatomic, copy) NSString *is_aftermark;
@property (nonatomic, copy) NSString *is_cancel;
@property (nonatomic, copy) NSString *is_close;
@property (nonatomic, copy) NSString *order_after_id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *send_type;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *state_str;

@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *total_fee;
@property (nonatomic, copy) NSString *total_postage;
@property (nonatomic, copy) NSString *total_price;
@property (nonatomic, copy) NSString *worksheet_id;

@property (nonatomic, strong) NSDictionary *goods;
@property (nonatomic, strong) NSDictionary *store;
@property (nonatomic, copy)NSString* created_at;
@property (nonatomic, strong) NSArray *vaild;

@property (nonatomic, strong) StoreModel *storemodel;




- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)modelWithDictionary:(NSDictionary *)dictionary;

@end
