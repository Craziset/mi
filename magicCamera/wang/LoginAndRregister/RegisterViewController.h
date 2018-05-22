//
//  RegisterViewController.h
//  wpw
//
//  Created by Myself on 2017/11/17.
//  Copyright © 2017年 Myself. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : sywBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phonenum;
@property (weak, nonatomic) IBOutlet UITextField *yanzzhengma;
- (IBAction)yanzhengBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *RegistBtn;
- (IBAction)Registerbtn:(id)sender;

@end
