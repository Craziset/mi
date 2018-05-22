

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface HWHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (NSString*)getUUID;
//带图层指示框的get请求
+ (void)getWithHUD:(UIView *)view WithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
//带图层指示框的请求
+ (void)postWithHUD:(UIView *)view WithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
//带json的数据上传
+ (void)postJson:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


//文件上传
/**
 FileDatas : 需要上传的文件的具体数据数组
 name : 服务器那边接收文件用的参数名
 fileNames : （告诉服务器）所上传文件的文件名数组
 mimeTypes : 所上传文件的文件类型数组 例如 @"image/png"  @"image/jpeg"
*/
+ (void)post:(NSString *)url params:(NSDictionary *)params fileDatas:(NSArray *)fileDatas name:(NSString *)name fileNames:(NSArray *)fileNames mimeTypes:(NSArray *)mineTypes success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

//文件下载
+ (void)downloadTaskWithURL:(NSString *)urlstr  completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;



//获取当前时间 精确到毫秒
+ (NSString *)getTimeNow;

@end
