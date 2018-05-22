//
//  XXJudgment.m
//  Step
//
//  Created by corepass on 17/5/16.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "XXJudgment.h"

@implementation XXJudgment



+ (BOOL)stringWithNill:(NSString *)string
{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""] ||[string isKindOfClass:[NSNull class]] ||[string isEqual:[NSNull null]]||string == nil) {
        return YES;
    }else
    {
        return NO;
    }
}

@end
