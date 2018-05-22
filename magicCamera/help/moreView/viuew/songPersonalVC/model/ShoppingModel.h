//
//  ShoppingModel.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject


@property(copy,nonatomic) NSString *imageName;//商品图片
@property(copy,nonatomic) NSString *goodsTitle;//商品标题
@property(copy,nonatomic) NSString *goodsType;//商品类型
@property(copy,nonatomic) NSString *goodsPrice;//商品单价
@property(assign,nonatomic) BOOL selectState;//是否选中状态
@property(assign,nonatomic) int goodsNum;//商品个数



@property (nonatomic, copy) NSString *brand_name; //牌子
@property (nonatomic, copy) NSString *colour_name; //颜色
@property (nonatomic, copy) NSString *has_preferential; //有优惠
@property (nonatomic, assign) NSInteger order_detail_number; //订单详情数量
@property (nonatomic, copy) NSString *original_price; //原价
@property (nonatomic, copy) NSString *preferential_price; //优惠价
@property (nonatomic, copy) NSString *product_id; //产品id
@property (nonatomic, copy) NSString *product_temp_name; //产品代表名称
@property (nonatomic, assign) NSInteger quantity; //数量
@property (nonatomic, copy) NSString *size_name; //尺码
@property (nonatomic, copy) NSString *sku;

@property (nonatomic, strong) NSArray *thumbnail; //缩略图
@property (nonatomic, strong) NSArray *original_image; //原图
@property (nonatomic, strong) NSArray *gift; //礼物/赠品

//购物车
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *is_sale;
@property (nonatomic, assign) NSInteger is_select;
@property (nonatomic, copy) NSString *is_shelves;
@property (nonatomic, copy) NSString *product_temp_id;
@property (nonatomic, copy) NSString *shop_car_id;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *product_image;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *name;



-(instancetype)initWithShopDict:(NSDictionary *)dict;




@end
