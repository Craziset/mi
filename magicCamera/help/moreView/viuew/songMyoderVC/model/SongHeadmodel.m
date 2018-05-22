//
//  SongHeadmodel.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongHeadmodel.h"

@implementation SongHeadmodel
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    return [[SongHeadmodel alloc] initWithDictionary:dictionary];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"order_id"]) {
        self.Orderorder_idStr = [NSString stringWithFormat:@"%@", value];
    }if ([key isEqualToString:@"good_total_quantity"]){
        self.Ordergood_total_quantityStr = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"total_price"]){
        self.Ordertotal_priceStr = [NSString stringWithFormat:@"%@",value];
    }else if([key isEqualToString:@"state"]){
        self.OrderStateStr = [NSString stringWithFormat:@"%@",value];
    }
    
//    else if ([key isEqualToString:@"orderStatus"]){
//
//        self.OderTimeLab = [NSString stringWithFormat:@"%@", value];
//        ;
//    }

    
}
// 当赋值时, key 没有找到对应的属性, 则执行该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setGoods:(NSDictionary *)goods
{
    NSArray *array = [SongOrderTablemodel mj_objectArrayWithKeyValuesArray:goods[@"vaild"]];
    _vaild = array;
    
}

- (void)setStore:(NSDictionary *)store
{
    _storemodel = [StoreModel mj_objectWithKeyValues:store];
}



@end
