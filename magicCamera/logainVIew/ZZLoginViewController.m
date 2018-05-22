//
//  ZZLoginViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZLoginViewController.h"
#import "ZZRegisterViewController.h"
#import <UMSocialCore/UMSocialCore.h>

#import <sys/sysctl.h>

#import <net/if.h>

#import <net/if_dl.h>

@interface ZZLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
- (IBAction)clickLoginBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *QQBtn;

- (IBAction)clickWeChat:(UIButton *)sender;
- (IBAction)clickQQBtn:(UIButton *)sender;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger  second;



@end

@implementation ZZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.second = 60;
    
    _phoneTF.text = @"15201269722";
    _pwdTF.text = @"111111";
}

- (IBAction)clickLoginBtn:(UIButton *)sender {
    
    if (![SMGlobalMethod validateMobile:_phoneTF.text]){
        [ZJProgressHUD showStatus:@"请输入正确的手机号" andAutoHideAfterTime:1.1];
    }else if (self.pwdTF.text.length < 6) {
        [ZJProgressHUD showStatus:@"密码不少于6位" andAutoHideAfterTime:1.1];
    }else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.phoneTF.text;
        params[@"access_type"] = @"1";
        params[@"password"] = self.pwdTF.text;
        MJWeakSelf
        [HWHttpTool post:API_Login params:params success:^(id json) {
            //先改成yes
            
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                ZZUserManager *manager = [ZZUserManager shareManager];
                manager.isLogin = @YES;
                ZZUserModel *user = [ZZUserModel  mj_objectWithKeyValues:json[@"result"]];
                [manager saveUser:user];
                if (self.loginBlock) {
                    self.loginBlock();
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        } failure:^(NSError *error) {
            
        }];
    }
    
}


    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickWeChat:(UIButton *)sender {
    
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

- (IBAction)clickQQBtn:(UIButton *)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}



- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
        }else
        {
            UMSocialUserInfoResponse *resp = result;
            
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            
            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.unionGender);
            
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"openid"] = resp.openid;
            params[@"access_type"] = @"2";
            if (platformType == UMSocialPlatformType_WechatSession) {
                
                params[@"login_type"] = @"1";
                params[@"unique_id"] = resp.uid;
                params[@"nick_name"] = resp.name;
                params[@"avatar"] = resp.iconurl;
                params[@"udid"] = [HWHttpTool getUUID];
                params[@"mac_id"] = [self macaddress];
            }else if (platformType == UMSocialPlatformType_QQ){
                params[@"login_type"] = @"2";
                params[@"unique_id"] = resp.uid;
                params[@"nick_name"] = resp.name;
                params[@"avatar"] = resp.iconurl;
                params[@"udid"] = [HWHttpTool getUUID];
                params[@"mac_id"] = [self macaddress];
            }
            NSLog(@"para = %@",params);
            MJWeakSelf
            [HWHttpTool post:API_Login params:params success:^(id json) {
                //先改成yes
                if ([json[@"state"] isEqualToString:@"M00000"]) {
                    if([json[@"message"] isEqualToString:@"请绑定手机号"])
                    {
                        [self performSegueWithIdentifier:@"toKuaisu" sender:params];
                    }else
                    {
                        ZZUserManager *manager = [ZZUserManager shareManager];
                        manager.isLogin = @YES;
                        ZZUserModel *user = [ZZUserModel  mj_objectWithKeyValues:json[@"result"]];
                        [manager saveUser:user];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                    
                }
                [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toKuaisu"])
    {
        ZZRegisterViewController* rvc = (ZZRegisterViewController*)segue.destinationViewController;
        if ([sender isKindOfClass:[NSDictionary class]])
        {
            rvc.disanfangDic = sender;
            rvc.loginBlock = ^{
                if (self.loginBlock) {
                    self.loginBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            };
        }else
        {
            rvc.disanfangDic = nil;
        }
        
    }
}
- (NSString *)macaddress

{
    
    int mib[6];
    
    size_t len;
    
    char* buf;
    
    unsigned char* ptr;
    
    struct if_msghdr* ifm;
    
    struct sockaddr_dl* sdl;
    
    mib[0] = CTL_NET;
    
    mib[1] = AF_ROUTE;
    
    mib[2] = 0;
    
    mib[3] = AF_LINK;
    
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        
        printf("Error: if_nametoindex error/n");
        
        return NULL;
        
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 1/n");
        
        return NULL;
        
    }
    
    if ((buf = malloc(len)) == NULL) {
        
        printf("Could not allocate memory. error!/n");
        
        return NULL;
        
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 2");
        
        return NULL;
        
    }
    
    ifm = (struct if_msghdr *)buf;
    
    sdl = (struct sockaddr_dl *)(ifm + 1);
    
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
    
}

@end
