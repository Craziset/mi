//
//  ZZLogainViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/9/29.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZLogainViewController.h"
#import "wwtools.h"
#import "RegisterViewController.h"
#import "ForgetpasswordViewController.h"
@interface ZZLogainViewController ()
{
    int timeDown; //60秒后重新获取验证码
    NSTimer *timer;
}
@end

@implementation ZZLogainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)logain_button_clicked:(id)sender {
    
    BOOL isPhoneNum = [wwtools isValidatePhoneNum:_iphoneTextField.text];
    if (!isPhoneNum) {
        [ZJProgressHUD showStatus:@"请输入正确的手机号" andAutoHideAfterTime:1.1];
        
        
    }else if ([_passWord_TextField.text isEqualToString:@""]){
        
        //[ZJProgressHUD showErrorWithStatus:@"请设置密码"];
        [ZJProgressHUD showStatus:@"请设置密码" andAutoHideAfterTime:1.1];
        
    }else{
        
        [self logindata];
        
    }
    
}
#pragma 登录接口
-(void)logindata{
    
    NSDictionary  *parameters = @{@"phone":_iphoneTextField.text,@"access_type":@"1",@"password":_passWord_TextField.text};
    
    [afnObject POST:API_Login parameters:parameters success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            [ZJProgressHUD showStatus:@"登录成功" andAutoHideAfterTime:1.1];
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"result"] forKey:@"userinfo"];
            //ZZTheFirstVViewController*firtvc=[[ZZTheFirstVViewController alloc]init];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(id error) {
        
    } Cahche:NO];
    
}
-(void)handleTimer
    {
        
        if(timeDown>=0)
        {
            [_number_button setUserInteractionEnabled:NO];
            [_number_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            int sec = ((timeDown%(24*3600))%3600)%60;
            [_number_button setTitle:[NSString stringWithFormat:@"(%d)重发验证码",sec] forState:UIControlStateNormal];
            
        }
        else
        {
            [_number_button setUserInteractionEnabled:YES];
            [_number_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_number_button setTitle:@"重发验证码" forState:UIControlStateNormal];
            
            [timer invalidate];
            
        }
        timeDown = timeDown - 1;
    }
    
    
    
- (IBAction)back_ButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetpasswordBtn:(id)sender {
    ForgetpasswordViewController*forgetVC=[[ForgetpasswordViewController alloc]init];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (IBAction)fastRregisterBtn:(id)sender {
    RegisterViewController*registVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view   endEditing:YES];
}
@end
