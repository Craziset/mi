//
//  ZZTextViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/12/2.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZTextViewController.h"

@interface ZZTextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ZZTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"textDoc.plist" ofType:nil];
    NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSString *string = cityGroupArray[[self.numStr integerValue]];
    self.textView.text = string;
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
