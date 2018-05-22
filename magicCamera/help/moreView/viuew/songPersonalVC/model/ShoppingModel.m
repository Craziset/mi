//
//  ShoppingModel.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel



-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
        self.imageName = dict[@"imageName"];
        self.goodsTitle = dict[@"goodsTitle"];
        self.goodsPrice = dict[@"goodsPrice"];
        self.goodsNum = [dict[@"goodsNum"]intValue];
         self.goodsType = dict[@"goodsType"];
    
        self.selectState = [dict[@"selectState"]boolValue];
    
    return self;
}





@end
