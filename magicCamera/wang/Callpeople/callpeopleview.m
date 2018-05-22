//
//  callpeopleview.m
//  magicCamera
//
//  Created by Myself on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "callpeopleview.h"

@implementation callpeopleview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"callpeopleview" owner:self options:nil] lastObject];
        self.backview.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        self.backview2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        self.callimg.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
        self.frame = frame;
//        self.view1.layer.masksToBounds = YES;
//        self.view1.layer.cornerRadius = 4;
//        self.knowbut.layer.cornerRadius=15;
//
//        self.knowbut.titleLabel.font = [UIFont fontWithName:kFontNameR size:16*ratew];
//        self.contentLab.font = [UIFont fontWithName:kFontNameR size:18*ratew];
//        self.fuContentLab.font = [UIFont fontWithName:kFontNameR size:13*ratew];
    }
    return self;
}

- (IBAction)cacleBtn:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)callphone:(id)sender {
    [self removeFromSuperview];
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSString *phoneNum = [NSString stringWithFormat:@"400-678-6788"];
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebView];
}
@end
