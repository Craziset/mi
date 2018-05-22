//
//  ZZWenViewstingViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/16.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZWenViewstingViewController : sywBaseViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,copy)NSString *url;
@end
