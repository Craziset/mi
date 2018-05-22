//
//  ZZProductModel.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/15.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZCustomZoneModel;
@interface ZZProductTempModel : NSObject

/**
 "id": 137,
 "product_temp_id": "2017101610110153",
 "colour_id": 3,
 "custom_num_of_zones": 2,
 "state": 1,
 "sort": 1,
 "created_at": 1508132094,
 "updated_at": 1508132094,
 "original_price": "259",
 "colour_name": "彩蓝",
 "preferential_price": "259",
 "has_preferential": 0,
 "colour_code": "",
 "colour_image": "http://img-diymi6.taichirain.com/images/201705/f46b87fb644048ddb6c66863f6acec14.png",
 */

@property (nonatomic, copy) NSString *colour_id;
@property (nonatomic, copy) NSString *product_temp_id;
@property (nonatomic, copy) NSString *custom_num_of_zones;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *original_price;
@property (nonatomic, copy) NSString *colour_name;
@property (nonatomic, copy) NSString *preferential_price;

@property (nonatomic, copy) NSString *has_preferential;
@property (nonatomic, copy) NSString *colour_code;
@property (nonatomic, copy) NSString *colour_image;

@property (nonatomic, strong) NSArray *temp_custom_zones;
@property (nonatomic, copy) NSString *product_temp_name;
@property (nonatomic, strong)NSArray *coord;


@end
