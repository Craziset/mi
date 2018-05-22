//
//  ZZMerchandisCollectionViewMode.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ProductModel.h"
#import "ZZProductTempModel.h"
@implementation ProductModel

- (void)setColors:(NSArray *)colors {
    _colors = [ZZProductTempModel mj_objectArrayWithKeyValuesArray:colors];
}

@end
