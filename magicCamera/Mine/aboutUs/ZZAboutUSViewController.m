//
//  ZZAboutUSViewController.m
//  magicCamera
//
//  Created by LONG on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZAboutUSViewController.h"

@interface ZZAboutUSViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation ZZAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:API_AboutUS]]];
    
    
    [ZJProgressHUD showStatus:@"加载中，请稍后。。。"];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [ZJProgressHUD hideHUD];

 [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];//修改百分比即可
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
