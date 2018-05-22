//
//  ZZMerchandisCollectionViewMode.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZMerchandisCollectionViewMode.h"

@implementation ZZMerchandisCollectionViewMode
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    return [[ZZMerchandisCollectionViewMode alloc] initWithDictionary:dictionary];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
        if ([key isEqualToString:@"profile_image"]) {
            self.imageMerchandisCollection = [NSString stringWithFormat:@"%@", value];
        } else if ([key isEqualToString:@"name"]){
            self.upLebel = [NSString stringWithFormat:@"%@", value];
            ;
        }else if ([key isEqualToString:@"default_price"]){
            self.downLabel = [NSString stringWithFormat:@"%@", value];
            ;
        }else if ([key isEqualToString:@"product_temp_id"]){
            self.product_temp_id = [NSString stringWithFormat:@"%@", value];
            ;
        }else if ([key isEqualToString:@"thumbnail"]){
            self.thumbnail = [NSString stringWithFormat:@"%@", value];
            ;
        }else if ([key isEqualToString:@"original_image"]){
            self.original_image = [NSString stringWithFormat:@"%@", value];
            ;
        }


    
    
}
// 当赋值时, key 没有找到对应的属性, 则执行该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
