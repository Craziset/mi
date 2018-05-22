//
//  afnObject.m
//  网址
//
//  Created by 王梦雅 on 16/10/21.
//  Copyright © 2016年 song. All rights reserved.
//

#import "afnObject.h"
#import "AFNetworking.h"
#import "SongCahcae.h"
@implementation afnObject

+(void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))resposeValue failure:(void (^)(id error))Error Cahche:(BOOL)Cahche{
    [[self AFNetManager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         resposeValue (responseObject);//这个是将成功的返回数据
        if (Cahche == YES) {
            
        [self Savecahche:urlString Save:responseObject];
            
        }else{
            
           // NSLog(@"不进行缓存");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         Error(error);//这个是将失败的数据返回来
         [XHToast showBottomWithText:@"获取数据失败" bottomOffset:150 duration:2.5f];
         [ZJProgressHUD hideAllHUDs];
    }];
}

+(void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))resposeValue failure:(void(^)(id error))Error Cahche:(BOOL)Cahche{
    [[self AFNetManager] GET:urlString
                  parameters:parameters
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        resposeValue (responseObject);
                        if (Cahche == YES) {
                            [self Savecahche:urlString Save:responseObject];
                        }else{
                          //  NSLog(@"不进行缓存");
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        resposeValue([SongCahcae qsh_ReadCache:urlString]);
                    }];
    
}

//保存缓存
+(void)Savecahche:(NSString *)strCahche Save:(id)responseObject{
    
   [SongCahcae qsh_saveDataCache:responseObject forKey:strCahche];


}

//移除缓存
+(void)RemoveAllCache{

   [SongCahcae qsh_RemoveAllCache];//移除缓存

//[SongCahcae qsh_RemoveChache:@"1123"];//移除对应的某一个缓存


}

+(id)ReaderCache:(NSString *)str{
    
  return [SongCahcae qsh_ReadCache:str];//取到缓存
    
}

+(NSString *)GetAllHttpCacheSize{
    
    return  [SongCahcae qsh_GetAllHttpCacheSize];  //计算缓存的大小

}




+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithFormDataArray:(NSArray<FormData *> *)formDataArray
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    
    
    [[self AFNetManager] POST:URLString
                   parameters:parameters
    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (FormData * data in formDataArray) {
            [formData appendPartWithFileData:data.data
                                        name:data.name
                                    fileName:data.fileName
                                    mimeType:data.mimeType];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        NSLog(@"%lf",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //   [MBProgressHUD showMessage:error.localizedDescription];
        
        failure(error);
    }];
    
}


/**
 *  公用一个AFHTTPSessionManager
 *
 *  @return AFHTTPSessionManager
 在这里可以适应不同的AFHTTPSessionManager类型数据,之所以单独拿出来,方便可以随时的改变
 */

+(AFHTTPSessionManager *)AFNetManager
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //设置请求的超时时间
        //manager.requestSerializer.timeoutInterval = 20.f;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    });
    
    return manager;
}

@end
