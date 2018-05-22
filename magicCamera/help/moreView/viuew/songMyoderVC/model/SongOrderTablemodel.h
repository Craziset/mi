//
//  SongOrderTablemodel.h
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//
#import "SuperOrderModel.h"
#import <Foundation/Foundation.h>

@interface SongOrderTablemodel : SuperOrderModel

/**
 
 //购物车
 "brand_id" = 2016121510050102;
 "is_sale" = 1;
 "is_select" = 1;
 "is_shelves" = 1;
 "product_temp_id" = 2017052351561005;
 "shop_car_id" = 393;
 stock = 58;
 "user_id" = 10004;
 
 
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
 */

@property (nonatomic, copy) NSString *brand_name; //牌子
@property (nonatomic, copy) NSString *colour_name; //颜色
@property (nonatomic, copy) NSString *has_preferential; //有优惠
@property (nonatomic, copy) NSString *order_detail_number; //订单详情数量
@property (nonatomic, copy) NSString *original_price; //原价
@property (nonatomic, copy) NSString *preferential_price; //优惠价
@property (nonatomic, copy) NSString *product_id; //产品id
@property (nonatomic, copy) NSString *product_temp_name; //产品代表名称
@property (nonatomic, copy) NSString *quantity; //数量
@property (nonatomic, copy) NSString *size_name; //尺码
@property (nonatomic, copy) NSString *sku;

@property (nonatomic, strong) NSArray *thumbnail; //缩略图
@property (nonatomic, strong) NSArray *original_image; //原图
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSArray *gift; //礼物/赠品

//购物车
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *is_sale;
@property (nonatomic, copy) NSString *is_select;
@property (nonatomic, copy) NSString *is_shelves;
@property (nonatomic, copy) NSString *product_temp_id;
@property (nonatomic, copy) NSString *shop_car_id;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *user_id;


- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)modelWithDictionary:(NSDictionary *)dictionary;

@end
