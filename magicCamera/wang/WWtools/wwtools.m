//
//  wwtools.m
//  magicCamera
//
//  Created by Myself on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "wwtools.h"

@implementation wwtools
+(BOOL)isValidatePhoneNum:(NSString *)num  {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(1)\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:num];
}
@end
