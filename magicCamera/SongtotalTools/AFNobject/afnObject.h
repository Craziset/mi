//
//  afnObject.h
//  网址
//
//  Created by 王梦雅 on 16/10/21.
//  Copyright © 2016年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjSingle.h"
@interface afnObject : NSObject

ObjSingleH;

//需缓存的时候
+ (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))resposeValue failure:(void(^)(id error))Error Cahche:(BOOL)Cahche;

+(void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))resposeValue failure:(void (^)(id error))Error Cahche:(BOOL)Cahche;

// 上传图片,可多张上传
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithFormDataArray:(NSArray *)formDataArray
     success:(void (^)( id responseObject))success
     failure:(void (^)( NSError *error))failure;




//缓存
+(void)Savecahche:(NSString *)strCahche Save:(id)responseObject;
//移除缓存
+(void)RemoveAllCache;
//读取到某一个缓存
+(id)ReaderCache:(NSString *)str;
//计算某一个缓存的大小
+(NSString *)GetAllHttpCacheSize;

@end




@interface FormData : NSObject
/**请求参数名*/
@property (nonatomic, copy, readwrite) NSString *name;
/**保存到服务器的文件名*/
@property (nonatomic, copy, readwrite) NSString *fileName;
/**文件类型*/
@property (nonatomic, copy, readwrite) NSString *mimeType;
/**二进制数据*/
@property (nonatomic, strong, readwrite) NSData *data;





@end



