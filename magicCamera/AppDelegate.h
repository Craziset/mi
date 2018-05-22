//
//  AppDelegate.h
//  magicCamera
//
//  Created by 张展展 on 2017/9/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@protocol PayDelegate<NSObject>

- (void)wxPaySuccesByResp:(BaseResp *)resp;
- (void)aliPayResult:(NSDictionary *)result;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) id<PayDelegate> payDelegate;



@end

