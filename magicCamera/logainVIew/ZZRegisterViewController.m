//
//  ZZRegisterViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/9/29.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZRegisterViewController.h"
#import "ZZUserModel.h"

@interface ZZRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)clickCodeBtn:(UIButton *)sender;
- (IBAction)clickRegisterBtn:(UIButton *)sender;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger  second;

@property (nonatomic, assign) BOOL isDisanfang;

@end

@implementation ZZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.disanfangDic != nil)
    {
        self.isDisanfang = YES;
        [self.registerBtn setTitle:@"绑定手机号" forState:UIControlStateNormal];
        UIView* view = [self.view viewWithTag:100];
        view.hidden = YES;
    }else
    {
        self.isDisanfang = NO;
    }
    self.second = 60;

}

- (void)timerFire{
    self.second -- ;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.second] forState:(UIControlStateNormal)];
    if (self.second <= 0) {
        [self stopTime];
        
    }
    
}

- (void)stopTime{
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                self.second = 60;
                [self.codeBtn setTitle:[NSString stringWithFormat:@"点击获取验证码"] forState:(UIControlStateNormal)];
                self.codeBtn.enabled = YES;
                
            }
        }
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

- (IBAction)clickCodeBtn:(UIButton *)sender {
    
    
    if ([SMGlobalMethod validateMobile:_phoneTF.text]) {
        self.codeBtn.enabled = NO;
        [self registerSendCode];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }else
    {
        [ZJProgressHUD showStatus:@"请输入正确的手机号" andAutoHideAfterTime:1.1];
        
    }
}

- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    if (![SMGlobalMethod validateMobile:_phoneTF.text]){
        [ZJProgressHUD showStatus:@"请输入正确的手机号" andAutoHideAfterTime:1.1];
    }else if (self.codeTF.text.length < 4) {
        [ZJProgressHUD showStatus:@"请输入正确的验证码" andAutoHideAfterTime:1.1];
    }else if ((self.pwdTF.text.length < 6)&&(!self.isDisanfang)) {
        [ZJProgressHUD showStatus:@"密码不少于6位" andAutoHideAfterTime:1.1];
    }else
    {
        if(self.isDisanfang)
        {
            NSDictionary* dic = @{@"identifying":self.codeTF.text,@"phone":self.phoneTF.text};
            [HWHttpTool post:API_CheckCaptcha params:dic success:^(id json) {
               
                if ([json[@"state"] isEqualToString:@"M00000"])
                {
                    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.disanfangDic];
                    params[@"phone"] = self.phoneTF.text;
                    params[@"access_type"] = @"3";
                    MJWeakSelf
                    [HWHttpTool post:API_Login params:params success:^(id json) {
                        
                        if ([json[@"state"] isEqualToString:@"M00000"]) {
                            ZZUserManager *manager = [ZZUserManager shareManager];
                            manager.isLogin = @YES;
                            ZZUserModel *user = [ZZUserModel  mj_objectWithKeyValues:json[@"result"]];
                            [manager saveUser:user];
                            if (self.loginBlock) {
                                self.loginBlock();
                            }
                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        }
                        [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
                    } failure:^(NSError *error) {
                        
                        NSLog(@"%@",error);
                    }];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }else
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phone"] = self.phoneTF.text;
            params[@"captcha"] = self.codeTF.text;
            params[@"access_type"] = @"0";
            params[@"password"] = self.pwdTF.text;
            MJWeakSelf
            [HWHttpTool post:API_Login params:params success:^(id json) {
                
                if ([json[@"state"] isEqualToString:@"M00000"]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
            }];
        }
    }
    
}


- (void)registerSendCode {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.phoneTF.text;
    params[@"send_type"] = @0;
    MJWeakSelf
    [HWHttpTool post:API_Captcha params:params success:^(id json) {
        
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            
        }else
        {
            [weakSelf stopTime];
            
        }
        [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
    } failure:^(NSError *error) {
        [weakSelf stopTime];
        
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger length = textField.text.length - range.length + string.length;
    if (textField == self.phoneTF) {
        return (length <= 11);
    }else if (textField == self.codeTF){
        return (length <= 6);
    }else if (textField == self.pwdTF){
        return (length <= 20);
    }
    return YES;
}



@end
