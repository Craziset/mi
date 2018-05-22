//
//  ZZMerchandisCollectionViewMode.h
//  magicCamera
//
//  Created by 宋建 on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZMerchandisCollectionViewMode : NSObject

@property (copy, nonatomic) NSString *imageMerchandisCollection;
@property (copy, nonatomic) NSString *upLebel;
@property (copy, nonatomic) NSString *downLabel;
@property (copy, nonatomic) NSString *product_temp_id;
@property (copy, nonatomic) NSString *thumbnail;
@property (nonatomic, copy) NSString *original_image;


- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)modelWithDictionary:(NSDictionary *)dictionary;


@end
