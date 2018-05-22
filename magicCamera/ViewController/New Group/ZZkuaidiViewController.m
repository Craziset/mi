//
//  ZZkuaidiViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZkuaidiViewController.h"

@interface ZZkuaidiViewController ()

@end

@implementation ZZkuaidiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nibBundleOrNil];
        ZZkuaidiViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"kuaidi"];
        self = message;
    }
    return  self;
}

@end
