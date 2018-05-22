
#import "CommonTool.h"

@implementation CommonTool

// 弹出警告
+(void)showAlert:(NSString *)message from:(UIViewController *)viewController
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });

}

+(void)alertViewController:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController withAMessage:(NSString *)amessage and:(UIView *)view withtag:(NSString *)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([tag isEqualToString:@"tel"]) {
           // NSLog(@"通话");
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",amessage];
            UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
            [view addSubview:callWebview];

        }else if ([tag isEqualToString:@"amess"]){
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",amessage]];
            [[UIApplication sharedApplication] openURL:url];
        }
    
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    
    
    }
+(void)alertViewController:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    
}

+(void)alertViewnet:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    

}

+(void)alertViewControll:(UIViewController *)viewCone to:(UIViewController *)viewControllertwo
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        viewCone.hidesBottomBarWhenPushed = YES;
        [viewCone.navigationController pushViewController:viewControllertwo animated:YES];
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [viewCone presentViewController:alertController animated:YES completion:nil];
}













@end
