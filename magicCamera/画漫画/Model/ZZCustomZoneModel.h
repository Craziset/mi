//
//  ZZCustomZoneModel.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/15.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCustomZoneModel : NSObject

/**
 "original_image": "http://img-diymi6.taichirain.com/images/201710/f48566dab60379c7fbad92cb01729118.png",
 "thumbnail": "http://img-diymi6.taichirain.com/images/201710/5a0a55a28065ae66a87dc749341377e3.png",
 "template_mask_url": "",
 "template_mask_thumbnail_url": "",
 "template_mask_clear_bg_url": "",
 "template_mask_clear_bg_thumbnail_url": "",
 "original_price": "0.00"
 */

@property (nonatomic, copy) NSString *original_image;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *template_mask_url;
@property (nonatomic, copy) NSString *template_mask_thumbnail_url;
@property (nonatomic, copy) NSString *template_mask_clear_bg_url;
@property (nonatomic, copy) NSString *template_mask_clear_bg_thumbnail_url;
@property (nonatomic, copy) NSString *original_price;




@end
