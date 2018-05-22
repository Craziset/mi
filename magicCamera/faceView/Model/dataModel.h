//
//  dataModel.h
//  FaceImage
//
//  Created by 徐征 on 2017/10/28.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject
/**
 "coord_x" = "3540/7100";
 "coord_y" = "2165/4927";
 createdAt = "2017-10-28 09:56:40";
 height = 414;
 objectId = 8eXB4446;
 updatedAt = "2017-10-28 14:55:25";
 username = "\U519b\U4eba\U75372";
 width = 414;
 */

@property (nonatomic, copy) NSString *coord_x;
@property (nonatomic, copy) NSString *coord_y;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *username;



@end
