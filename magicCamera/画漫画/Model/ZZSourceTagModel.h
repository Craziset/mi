//
//  ZZSourceTagModel.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/15.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZSourceTagModel : NSObject

/**
 "tag_id": 47,
 "tag_name": "推荐标签",
 "tag_type": 2,
 "original_image": "http://img-diymi6.taichirain.com/images/201801/3d6c455d9d9250ab7e1bdd5c93b19372.png",
 "series_id": "",
 "is_only_show": 0
 */
@property (nonatomic, copy) NSString *tag_id;
@property (nonatomic, copy) NSString *tag_name;
@property (nonatomic, copy) NSString *tag_type;
@property (nonatomic, copy) NSString *original_image;
@property (nonatomic, copy) NSString *series_id;
@property (nonatomic, copy) NSString *is_only_show;


@end
