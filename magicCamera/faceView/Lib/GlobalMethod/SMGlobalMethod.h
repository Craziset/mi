//
//  SMGlobalMethod.h
//  Smios
//
//  Created by hao on 15/11/27.
//  Copyright (c) 2015年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define signStr @"ZL35ImuNGGhBn48SCPMduLHV1iz0vHkRdl0zb6H5AgMBA"

@interface SMGlobalMethod : NSObject

/**
 date转时间yyyyMMdd
 */
+(NSString *)getTimeFromTimeDaY:(NSDate *)date;

/**
 时间戳转时间
 */
+(NSString *)getTimeFromTimeSp:(NSString *)timeSp;

/**
 时间戳转时间
 */
+(NSString *)getTimeFromShortTimeSpY:(NSString *)shortTimeSp;

/**
 时间戳转时间yyyy-MM-dd
 */
+(NSString *)getTimeFromShortTimeSp:(NSString *)shortTimeSp;

/**
 date转时间
 */
+(NSString *)getTimeFromTimeDa:(NSDate *)date;
+(NSString *)getTimeFromShortTimeDa:(NSDate *)date;

/** 
 时间文本转dateShort
 */
+(NSDate *)getTimeDateFromeShortTimeStryy:(NSString *)timeStr;

/**
 获取当前时间戳
 */
+(NSString *)getTimeSp;

/**
 时间文本转date
 */
+(NSDate *)getTimeDateFromeTimeStr:(NSString *)timeStr;
+(NSDate *)getTimeDateFromeShortTimeStr:(NSString *)timeStr;

///date转时间戳
+(NSString *)getTimeSpFromeTimeDate:(NSDate *)date;
///时间文本转date(YYYYMMddHHmm)
+ (NSDate *)getTimeDateFromeTimeStrWithYYY:(NSString *)timeStr;
///date转时间yyyyMMddHHmm
+(NSString *)getTimeFromTimeDaYY:(NSDate *)date;

///获取当前星期
+(NSString*)getweek;

/**
 根据时间获取所在月（日，周，年）的开始时间结束时间
 */
+ (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate;

///自动消失的提示框
+(void)showMessage:(NSString *)message;

#pragma mark-- 正则判断
///邮箱
+ (BOOL) validateEmail:(NSString *)email;
///手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
///电话号验证
+ (BOOL)validateIsMobileNumber:(NSString *)mobileNum;
///车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
///车型
+ (BOOL) validateCarType:(NSString *)CarType;
///用户名
+ (BOOL) validateUserName:(NSString *)name;
///姓名正则
+ (BOOL)checkUserName : (NSString *) userName;
///密码
+ (BOOL) validatePassword:(NSString *)passWord;
///昵称
+ (BOOL) validateNickname:(NSString *)nickname;
///身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
///邮编
+ (BOOL) validatePostcode:(NSString *)nickname;
///字符
+ (BOOL) validateChinese:(NSString *)Chinese;
#pragma mark- 各类型数据转换
///字典转data
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
///字典转json串
+(NSString*)returnDictionaryToJson:(NSDictionary *)dic;
///数组转json格式
+ (NSString*)arrayToJson:(NSArray *)arr;
///json字符串转字典
+(NSDictionary *)jsonStrToDic:(NSString  *)jsonStr;
///转换html标签
+(NSString *)filterHTML:(NSString *)str;

#pragma mark-- 清理缓存
///计算单个文件大小
+(float)fileSizeAtPath:(NSString *)path;
///计算目录大小
+(float)folderSizeAtPath:(NSString *)path;
///清理缓存
+(void)clearCache:(NSString *)path;

#pragma mark -- md5
///MD5加密
+ (NSString *)md5:(NSString *)str;

///加时间戳加密文加密
+(NSString *)timeSignMd5:(NSString *)str;

///获取ip地址
+(NSString *)getIPAddress;

///计算并绘制字符串文本大小
+(CGSize)getSuitSizeWithString:(NSString *)text fontSize:(float)fontSize bold:(BOOL)bold sizeOfX:(float)x hasLimitMaxHeight:(BOOL)limit limitHeight:(float)heightMax;

/// 把字符串放入一个宽和高的lable 中 动态获取lable的高度和宽度
+(CGSize) getSizeWithString:(NSString *)str labelWidth:(int)labelWidth labelHeight:(int)labelHeight fontSize:(float)fontSize;

///文本框缩进
+(void)setTextFieldPaddingWithTextField:(UITextField *)TX;

////截取屏幕作为图片
+(UIImage *)screenshot:(UIView *)view;

///写入文件
+(void)writeFile:(NSMutableDictionary *)dic toFile:(NSString *)str;

///读取文件
+(NSMutableDictionary *)readFile:(NSString *)str;
/// 删除文件
+(void)removeFile:(NSString *)str;

///压缩图片
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
///保存图片到手机相册
-(void)tapSaveImageToIphone:(UIImage *)saveImage;

@end
