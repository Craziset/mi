

#import "HWHttpTool.h"
#import "MBProgressHUD.h"
#import "SMGlobalMethod.h"

@implementation HWHttpTool
//setAuthorizationHeaderFieldWithToken

+ (NSString*)getUUID
{
    NSString* uuid = [[NSUserDefaults standardUserDefaults]objectForKey:@"UUID"];
    if (uuid.length == 0)
    {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"UUID"];
    }
    return uuid;
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
   AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
   mgr.requestSerializer=[AFJSONRequestSerializer serializer];
   mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
   
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse* response = (NSHTTPURLResponse*)task.response;
        NSLog(@"%@",@(response.statusCode));
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript", nil];
    
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    // 2.发送请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse* response = (NSHTTPURLResponse*)task.response;
        NSLog(@"%@",@(response.statusCode));
        if (failure) {
            failure(error);
        }
        NSError *underError = error.userInfo[@"NSUnderlyingError"];
        
        NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
        
        NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",result);
    }];
}



//带图层指示框的get请求
+ (void)getWithHUD:(UIView *)view WithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager  *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 2.发送请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
}

//带图层指示框的post请求
+ (void)postWithHUD:(UIView *)view WithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 2.发送请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:view animated:YES];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:view animated:YES];
        if (failure) {
            failure(error);
        }
    }];
    
}
+ (void)postJson:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    // 2.发送请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//文件上传(图片)
+ (void)post:(NSString *)url params:(NSDictionary *)params fileDatas:(NSArray *)fileDatas name:(NSString *)name fileNames:(NSArray *)fileNames mimeTypes:(NSArray *)mineTypes success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    // 1.创建一个管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 在发送请求之前会自动调用这个block
        // 需要在这个block中添加文件参数到formData中
        if (fileDatas.count == fileNames.count && fileNames.count == mineTypes.count) {
            for (int i = 0; i < fileDatas.count; i ++) {
                [formData appendPartWithFileData:fileDatas[i] name:name fileName:fileNames[i] mimeType:mineTypes[i]];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//文件下载
+ (void)downloadTaskWithURL:(NSString *)urlstr  completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler{
    // 获得网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 创建请求对象
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 声明一个进度对象
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 告诉服务器下载的文本保存的位置在哪里
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
         completionHandler(response,filePath,error);
    }] resume];
    

}

+ (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
   NSString* timeNow = [[NSString alloc] initWithFormat:@"%@", date];
//    NSLog(@"%@", timeNow);
    return timeNow;
}

@end


