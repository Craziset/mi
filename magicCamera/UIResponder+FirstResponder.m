//
//  UIResponder+FirstResponder.m
//  magicCamera
//
//  Created by LONG on 2018/1/24.
//  Copyright © 2018年 张展展. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak id currentFirstResponder;


@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
