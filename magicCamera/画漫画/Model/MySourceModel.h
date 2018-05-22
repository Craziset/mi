//
//  MySourceModel.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/17.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySourceModel : NSObject

/*
 "creative_id": "2017052415225310056994",
 "user_id": 11074,
 "original_image": "http://img-diymi6.taichirain.com/images/201705/e8edf7d87f1597e33bf41420e5c4a4a4.png",
 "thumbnail": "http://img-diymi6.taichirain.com/images/201705/411edf9fca9a45317aa0c958e37433c2.png",
 "name": "自定义素材",
 "price": "0.00",
 "preferential_price": "0.00",
 "channel": 1,
 "original_price": "0.00"
 */

@property (nonatomic, copy) NSString *creative_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *original_image;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSString *source_pic_name;

@end
