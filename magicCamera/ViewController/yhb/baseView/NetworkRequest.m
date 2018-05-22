//
//  NetworkRequestModel.m
//  Rezhuo_2
//
//  Created by rzkj on 16/4/27.
//  Copyright © 2016年 rzkj. All rights reserved.
//

#import "NetworkRequest.h"
#import "AFHTTPSessionManager.h"



@implementation NetworkRequest

+(AFHTTPSessionManager*)getSession{
    //网络请求初始化
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.securityPolicy setAllowInvalidCertificates:YES];
    sessionManager.requestSerializer.timeoutInterval = 10.f;//改成10s
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];//回复序列化
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                @"text/html",
                                                                @"image/jpeg",
                                                                @"image/png",
                                                                @"application/octet-stream",
                                                                @"text/json",
                                                                @"text/javascript",
                                                                nil];
    return sessionManager;
}

#pragma mark - 网络请求，用户匹配
+(void)requestWithApi:(id)Api Params:(id)Params type:(NSString *)type withBlock:(resultBlock)block {
    //接口
    NSString *hostUrl = [NSString stringWithFormat:@"%@%@",host,Api];
    if ([type isEqualToString:@"GET"]) {
        NSString *params = @"";
        for (id obj in Params) {
            if (params.length==0) {
                params = [NSString stringWithFormat:@"%@=%@",obj,Params[obj]];
            }else{
                params = [NSString stringWithFormat:@"%@&%@=%@",params,obj,Params[obj]];
            }
        }
        NSString *getStr = [NSString stringWithFormat:@"%@?%@",hostUrl,params];
        NSLog(@"getParams->%@",getStr);
        [[NetworkRequest getSession] GET:getStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject->%@",responseObject);
            block(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    }else{
        NSLog(@"postParams->%@",Params);
        [[NetworkRequest getSession] POST:hostUrl parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject->%@",responseObject);
            block(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error->%@",error);
        }];
    }
}





//处理图片大小
-(NSData*)detailPicture:(UIImage*)image{
    NSData *imageData;
    if (UIImagePNGRepresentation(image)) {
        imageData = UIImagePNGRepresentation(image);//返回为png图像。
    }else {
        imageData = UIImageJPEGRepresentation(image, 1);//返回为JPEG图像。
    }
    //获取图片的大小
    float size = [imageData length]/1024.0;
    if (size>4096) {
        imageData = UIImageJPEGRepresentation(image, 4096.0/size);//对图片进行压缩
    }
    size = [imageData length]/1024.0;
    if (size>4096) {
       imageData = [self detailPicture:[UIImage imageWithData:imageData]];
    }
    return imageData;
}

//上传图片
-(void)updatePictureApi:(id)Api picArr:(NSArray*)picArr type:(NSString *)type withBlock:(resultBlock)block{
    NSString *hostUrl;
    for(int i=0;i<picArr.count;i++){//批量传图片
        [[NetworkRequest getSession] POST:hostUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *img = picArr[i];
            //获取图片的大小
            NSData *imageData = [self detailPicture:img];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSString *count = [NSString stringWithFormat:@"%f",(float)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
            NSString *indexStr = [NSString stringWithFormat:@"%d",i];
            dispatch_async(dispatch_get_main_queue(), ^{
                block(@[indexStr,count]);
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}







@end
