//
//  SongOrderTablemodel.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//
#import "SongOrderTablemodel.h"
@implementation SongOrderTablemodel
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    return [[SongOrderTablemodel alloc] initWithDictionary:dictionary];
}
-(void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"thumbnail"]) {
        NSMutableArray *imageArr = [[NSMutableArray alloc]initWithCapacity:0];
        imageArr = value;
        self.ImagesStr = [NSString stringWithFormat:@"%@",imageArr[0]];
    } else if ([key isEqualToString:@"product_temp_name"]){
        self.ProductNameStr = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"original_price"]){
        self.ProductPriceStr = [NSString stringWithFormat:@"%@",value];
    }else if([key isEqualToString:@"quantity"]){
        self.ProductNumberStr = [NSString stringWithFormat:@"%@",value];
    }else if([key isEqualToString:@"colour_name"]){
        self.ProductColour_nameStr = [NSString stringWithFormat:@"%@",value];
    }
}
// 当赋值时, key 没有找到对应的属性, 则执行该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
