//
//  NetworkRequestModel.h
//  Rezhuo_2
//
//  Created by rzkj on 16/4/27.
//  Copyright © 2016年 rzkj. All rights reserved.
//

#import <Foundation/Foundation.h>

/****************************接口*********************************/
#define host @"http://mi6.wulinnet.com/api/"

/****************************接口*********************************/
#define MgetDrawingImg   @"drawing/get-drawing-background"//获取画板背景图列表 POST
#define MgetSource       @"source-pic/get-source"//获取画板背景图列表 POST
/****************************接口*********************************/

typedef void(^resultBlock)(id responseObject);//返回


@interface NetworkRequest : NSObject

//网络请求
+(void)requestWithApi:(id)Api Params:(id)Params type:(NSString *)type withBlock:(resultBlock)block;

//上传图片
-(void)updatePictureApi:(id)Api picArr:(NSArray*)picArr type:(NSString *)type withBlock:(resultBlock)block;


@end










