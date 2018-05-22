//
//  XXAddModel.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXAddModel : NSObject

/**
 address = "\U6c49\U9633\U8def38\U53f7";
 "address_id" = 38;
 "address_type" = 0;
 area = "\U6b66\U6c5f\U533a";
 city = "\U97f6\U5173";
 "complete_city_info" = "\U5e7f\U4e1c\U97f6\U5173\U6b66\U6c5f\U533a";
 consignee = "\U5218\U5173\U5f20";
 country = "\U4e2d\U56fd";
 phone = 13302566997;
 prov = "\U5e7f\U4e1c";
 
 */
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *address_type;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *complete_city_info;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *prov;




@end
