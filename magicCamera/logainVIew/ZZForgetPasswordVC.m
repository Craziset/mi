//
//  ZZForgetPasswordVC.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/28.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZForgetPasswordVC.h"

@interface ZZForgetPasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
- (IBAction)getCode:(UIButton *)sender;
- (IBAction)clickForgetPasswordBtn:(UIButton *)sender;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger  second;

@end

@implementation ZZForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)getCode:(UIButton *)sender {
    
    
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

- (IBAction)clickForgetPasswordBtn:(UIButton *)sender {
    
    if (![SMGlobalMethod validateMobile:_phoneTF.text]){
        [ZJProgressHUD showStatus:@"请输入正确的手机号" andAutoHideAfterTime:1.1];
    }else if (self.codeTF.text.length < 4) {
        [ZJProgressHUD showStatus:@"请输入正确的验证码" andAutoHideAfterTime:1.1];
    }else if (self.pwdTF.text.length < 6) {
        [ZJProgressHUD showStatus:@"密码不少于6位" andAutoHideAfterTime:1.1];
    }else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.phoneTF.text;
        params[@"captcha"] = self.codeTF.text;
//        params[@"access_type"] = @(-1);
        params[@"password"] = self.pwdTF.text;
        MJWeakSelf
        [HWHttpTool post:API_ForgetPasswd params:params success:^(id json) {
            
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)registerSendCode {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.phoneTF.text;
    params[@"send_type"] = @(0);
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
