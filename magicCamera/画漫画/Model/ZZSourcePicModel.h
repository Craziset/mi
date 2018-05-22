//
//  ZZSourcePicModel.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/15.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZSourcePicModel : NSObject

/**
 "audit_state" = 2;
 "has_preferential" = 0;
 "is_infinite_stock" = 1;
 "is_infinite_time" = 1;
 "is_shelves" = 1;
 "is_shelves_value" = "\U5df2\U4e0a\U67b6";
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/01052c9c864b6d55a5dc2f69285b781e.png";
 "original_price" = "\U514d\U8d39";
 "preferential_price" = "\U514d\U8d39";
 "small_image" = "http://img-diymi6.taichirain.com/images/201705/c80ca84a532e270eb2f3499f1e270104.png";
 sort = 38;
 "source_pic_id" = 2017052249571015;
 stock = 0;
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/795992ae7c7bbfc4ed7a919c4e2fbb03.png";
 "updated_at" = 1515559836;
 "user_id" = 0;
 */

@property (nonatomic, copy) NSString *audit_state;
@property (nonatomic, copy) NSString *has_preferential;
@property (nonatomic, copy) NSString *is_infinite_stock;
@property (nonatomic, copy) NSString *is_infinite_time;
@property (nonatomic, copy) NSString *is_shelves;
@property (nonatomic, copy) NSString *is_shelves_value;
@property (nonatomic, copy) NSString *original_image;
@property (nonatomic, copy) NSString *original_price;
@property (nonatomic, copy) NSString *preferential_price;
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *source_pic_id;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *user_id;



@end
