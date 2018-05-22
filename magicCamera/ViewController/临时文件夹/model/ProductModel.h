//
//  ZZMerchandisCollectionViewMode.h
//  magicCamera
//
//  Created by 宋建 on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

/*
 colors =     (
 {
 "colour_code" = "";
 "colour_id" = 2;
 "colour_image" = "http://img-diymi6.taichirain.com/images/201705/4fee2c3e3eca5283e0b7d911eb46d898.png";
 "colour_name" = "\U767d\U8272";
 "created_at" = 1495523823;
 "custom_num_of_zones" = 2;
 "has_preferential" = 0;
 id = 3;
 "original_price" = 139;
 "preferential_price" = 139;
 "product_temp_id" = 2017052310297974;
 sort = 10;
 state = 1;
 "temp_custom_zones" =             (
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/31a26e491448aad85ce3d4224b153f82.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/053e310213d17d2f8cb837686e1b92a5.jpg";
 },
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/21e2f47c0d639d2b43c01afbfb52ea8f.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/f6fbf62b304dd9077a7a7e5eba14580c.jpg";
 }
 );
 "updated_at" = 1500477048;
 },
 {
 "colour_code" = "";
 "colour_id" = 6;
 "colour_image" = "http://img-diymi6.taichirain.com/images/201705/de8b36485a3f2f34d22a90ff54def5c2.png";
 "colour_name" = "\U7ea2\U8272";
 "created_at" = 1495523823;
 "custom_num_of_zones" = 2;
 "has_preferential" = 0;
 id = 4;
 "original_price" = 139;
 "preferential_price" = 139;
 "product_temp_id" = 2017052310297974;
 sort = 7;
 state = 1;
 "temp_custom_zones" =             (
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/f4009d2882cc8ce262e34cfcf14cf986.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/395e790e792492bdc840d41c6969c75c.jpg";
 },
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/e33b681ea1f2bd8a9819105cc490cbe1.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/4febe0009d64b3cc332b8b67cfcfc16c.jpg";
 }
 );
 "updated_at" = 1498462218;
 },
 {
 "colour_code" = "";
 "colour_id" = 10;
 "colour_image" = "http://img-diymi6.taichirain.com/images/201705/666b750d59bec01815ee9d74ce89713d.png";
 "colour_name" = "\U9ebb\U7070";
 "created_at" = 1495523823;
 "custom_num_of_zones" = 2;
 "has_preferential" = 0;
 id = 5;
 "original_price" = 139;
 "preferential_price" = 139;
 "product_temp_id" = 2017052310297974;
 sort = 3;
 state = 1;
 "temp_custom_zones" =             (
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/446279849204061c948ca1ed7dbf2fd5.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/8c1e3991fe33f7d02d0b5f2af85c68e7.jpg";
 },
 {
 "original_image" = "http://img-diymi6.taichirain.com/images/201705/96ca62c6d0f0681bf51fb5dd423617f8.jpg";
 "original_price" = "50.00";
 "template_mask_clear_bg_thumbnail_url" = "";
 "template_mask_clear_bg_url" = "";
 "template_mask_thumbnail_url" = "";
 "template_mask_url" = "";
 thumbnail = "http://img-diymi6.taichirain.com/images/201705/7c565fdeca99d05698dcfee19d070561.jpg";
 }
 );
 "updated_at" = 1498462218;
 }
 );
 "default_price" = "139.00";
 description = "";
 "design_mode" = 1;
 "has_drafts" = 0;
 name = "\U7537\U7ae5\U5706\U9886T\U6064FM7213001";
 postage = 10;
 "product_draft_ids" =     (
 );
 "product_temp_category_id" = 3;
 "product_temp_id" = 2017052310297974;
 "temp_intro_h5_url" = "http://diymi6.taichirain.com/api/temp-detail?temp_id=2017052310297974";
 }
 */


@property (nonatomic, copy) NSString *default_price;
@property (nonatomic,copy)NSString *design_mode;
@property (nonatomic,copy)NSString *has_drafts;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *product_temp_id;
@property (nonatomic,copy)NSString *product_temp_category_id;
@property (nonatomic,strong)NSArray *colors;

//@property (nonatomic, copy) NSString *avatar;
//@property (nonatomic, copy) NSString *brand_name;
//@property (nonatomic, copy) NSString *channel;
//@property (nonatomic, copy) NSString *collect_num;
//@property (nonatomic, copy) NSString *colour_id;
//
//@property (nonatomic, strong) NSArray *gift;
//@property (nonatomic, copy) NSString *has_preferential;
//@property (nonatomic, copy) NSString *is_infinite_stock;
//@property (nonatomic, copy) NSString *is_infinite_time;
//@property (nonatomic, copy) NSString *is_shelves;
//
//@property (nonatomic, copy) NSString *nick_name;
//@property (nonatomic, copy) NSString *off_shelves_time;
//@property (nonatomic, strong) NSArray *original_image;
//
//@property (nonatomic, copy) NSString *original_price;
//@property (nonatomic, copy) NSString *overflow_price;
//@property (nonatomic, copy) NSString *preferential_price;
//
//@property (nonatomic, copy) NSString *prod_md5;
//@property (nonatomic, copy) NSString *product_id;
//
//@property (nonatomic, copy) NSString *product_temp_name;
//@property (nonatomic, copy) NSString *sell_num;
//
//@property (nonatomic, copy) NSString *series_id;
//@property (nonatomic, copy) NSString *stock;
//@property (nonatomic, strong) NSArray *thumbnail;
//@property (nonatomic, copy) NSString *user_collection_id;
//@property (nonatomic, strong) NSArray *user_id;


@end
