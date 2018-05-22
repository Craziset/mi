//
//  ZZProductModel.m
//  magicCamera
//
//  Created by 徐征 on 2018/1/15.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import "ZZProductTempModel.h"
#import "ZZCustomZoneModel.h"

@implementation ZZProductTempModel

- (void)setTemp_custom_zones:(NSArray *)temp_custom_zones {
    _temp_custom_zones = [ZZCustomZoneModel mj_objectArrayWithKeyValuesArray:temp_custom_zones];
}



@end
