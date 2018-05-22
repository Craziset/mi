//
//  ZZProtocolViewController.m
//  magicCamera
//
//  Created by LONG on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZProtocolViewController.h"

@interface ZZProtocolViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *we;

@end

@implementation ZZProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [MBProgressHUD showMessage:@"加载中。。" toView:self.view];
   
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [ZJProgressHUD showStatus:@"加载中，请稍后。。。"];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * ducumentLocation = [[NSBundle mainBundle]pathForResource:self.indexStr ofType:@"pages"];
    NSURL *url = [NSURL fileURLWithPath:ducumentLocation];
    
    [self.we loadRequest:[NSURLRequest requestWithURL:url]];
    self.we.scalesPageToFit = NO;
    self.we.scrollView.delegate = self;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x > 0) {
        scrollView.contentOffset = CGPointMake(0, point.y);//这里不要设置为CGPointMake(0, 0)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [ZJProgressHUD hideHUD];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];//修改百分比即可
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
//    [webView stringByEvaluatingJavaScriptFromString:meta];//(initial-scale是初始缩放比,minimum-scale=1.0最小缩放比,maximum-scale=5.0最大缩放比,user-scalable=yes是否支持缩放)

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
