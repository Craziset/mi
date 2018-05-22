//
//  ThirdBtnView.m
//  QiChengApp
//
//  Created by 飞兔 on 16/8/6.
//  Copyright © 2016年 杨元. All rights reserved.
//

#import "ThirdBtnView.h"
#import "UIColor+Hex.h"
@implementation ThirdBtnView
#define SCREENWITH [UIScreen mainScreen].bounds.size.width
-(id)initWithFrame:(CGRect)frame WithBtnNameArr:(NSMutableArray *)arr WithNsinteg:(NSUInteger)tag
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self creatUIWithBtnNameArr:arr AndNsinteg:tag];
    }
    return self;
}
-(void)creatUIWithBtnNameArr:(NSMutableArray *)btnNameArr AndNsinteg:(NSUInteger)tag
{
    btnArray =  [NSMutableArray arrayWithCapacity:0];
    UIImageView * topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*SCREEN_HEIGHT/XMultiple)];
    topImage.userInteractionEnabled = YES;
    //topImage.layer.borderColor = [UIColor colorWithHexString:@"#212221"].CGColor;
    //topImage.layer.borderWidth = 1;
    [self addSubview:topImage];
    CGFloat btnWith = SCREENWITH/btnNameArr.count;
    CGFloat btnHeight = CGRectGetHeight(self.frame);
    self.normalBotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42, SCREENWITH, 2)];
    self.normalBotImage.image = [UIImage imageNamed:@"xzx.png"];
    NSString *secBotImageTag = [[NSUserDefaults standardUserDefaults]objectForKey:@"secBotImageTag"];
    if ([secBotImageTag intValue]==0) {
        self.secBotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,65*SCREEN_HEIGHT/XMultiple,btnWith, 1.5)];
    }else{
    self.secBotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,65*SCREEN_HEIGHT/XMultiple,btnWith, 1.5)];
    }
    //self.secBotImage.image = [UIImage imageNamed:@"xzx_d.png"];
    self.secBotImage.backgroundColor = RGBA(238, 218, 82, 1);
    self.secBotImage.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [topImage addSubview:self.secBotImage];
    for (NSInteger i = 0 ; i <btnNameArr.count ; i ++)
    {
        self.currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.currentBtn setTitle:btnNameArr[i] forState:UIControlStateNormal];
        self.currentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.currentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == tag)
        {
            self.currentBtn.frame = CGRectMake(i*WIDTH/btnNameArr.count, 0, WIDTH/btnNameArr.count, btnHeight);
            [self.currentBtn setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
            self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            CGPoint btnCenter =  self.currentBtn.center;
            self.secBotImage.center = CGPointMake(btnCenter.x, 40*HEIGHT/XMultiple);
        }
        else
        {    self.currentBtn.frame = CGRectMake(i*WIDTH/btnNameArr.count, 0, WIDTH/btnNameArr.count, btnHeight);
            [self.currentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        self.currentBtn.tag = i;
        [topImage addSubview:self.currentBtn];
        [btnArray addObject:self.currentBtn];
    }
}
-(void)btnClick:(UIButton *)button
{
    for (int i = 0; i<btnArray.count; i++) {
        UIButton *btn = btnArray[i];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.frame = CGRectMake(i*SCREENWITH/btnArray.count, 0, SCREENWITH/btnArray.count,CGRectGetHeight(self.frame));
    }
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
    CGPoint btnCenter =  button.center;
    if (button.tag == 0) {
        self.secBotImage.center = CGPointMake(btnCenter.x-5, 40*HEIGHT/XMultiple);
    }else{
    self.secBotImage.center = CGPointMake(btnCenter.x, 40*HEIGHT/XMultiple);
    }
    _currentIndex = button.tag;
    if ([self.delegate respondsToSelector:@selector(didtapBtn:)])
    {
        [self.delegate didtapBtn:button];
    }
}
-(CGSize)buttonSizeOfTitle:(NSString*)title
{
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSParagraphStyleAttributeName : style };
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(WIDTH, CGRectGetHeight(self.frame))
                                          options:opts
                                       attributes:attributes
                                          context:nil].size;
    return textSize;
}

@end
