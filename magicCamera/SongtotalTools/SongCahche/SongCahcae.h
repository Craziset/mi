//
//  SongCahcae.h
//  网址
//
//  Created by 王梦雅 on 16/10/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjSingle.h"
@interface SongCahcae : NSObject<NSCopying>

ObjSingleH;

/**
 *   存 或 改
 *
 *
 
 
 data :网络数据
 *
 *  key : key
 */
+ (void)qsh_saveDataCache:(id)data forKey:(NSString *)key;

/**读取*/
+ (id)qsh_ReadCache:(NSString *)key;

/**读取缓存文件的大小*/
+ (NSString *)qsh_GetAllHttpCacheSize ;

/**是否缓存*/
+ (BOOL)qsh_IsCache:(NSString *)key ;

/**删除某个磁盘缓存文件*/
+ (void)qsh_RemoveChache:(NSString *)key ;

/**删除所有的磁盘换存文件*/
+ (void)qsh_RemoveAllCache ;


@end
