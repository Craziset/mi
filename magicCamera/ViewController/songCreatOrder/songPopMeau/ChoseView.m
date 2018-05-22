
//
//  ChoseView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//
#import "ChoseView.h"
@implementation ChoseView
@synthesize alphaiView,whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cancle,lb_line;
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        alphaiView.backgroundColor = [UIColor blackColor];
        alphaiView.alpha = 0.2;
        [self addSubview:alphaiView];
        //装载商品信息的视图
        whiteView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCR_HEIGHT-467, self.frame.size.width, 467)];
        whiteView.contentSize = CGSizeMake(0, HEIGHT);
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [whiteView addGestureRecognizer:tap];
        
        img = [[UILabel alloc] initWithFrame:CGRectMake(10,8, whiteView.frame.size.width/2-20, 15)];
        img.textAlignment = NSTextAlignmentLeft;
        img.font = [UIFont systemFontOfSize:15];
        [whiteView addSubview:img];
        
    
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(whiteView.frame.size.width/2+10,8, whiteView.frame.size.width/2-20, 15)];
        lb_price.textAlignment = NSTextAlignmentRight;
        lb_price.font = [UIFont systemFontOfSize:15];
        lb_price.textColor = [UIColor redColor];
        [whiteView addSubview:lb_price];
        
        //分界线
        lb_line = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+10, whiteView.frame.size.width, 0.5)];
        lb_line.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:lb_line];
        
        
        
        
        //确定按钮
        bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_sure.frame = CGRectMake(80, whiteView.frame.size.height-130,whiteView.frame.size.width-160, 40);
        [bt_sure setBackgroundColor:RGBA(240, 218, 81, 1)];
        [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
        bt_sure.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt_sure setTitle:@"立即购买" forState:0];
        bt_sure.layer.cornerRadius = 6;
        [bt_sure addTarget:self action:@selector(MerchOrButte:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:bt_sure];
    
        // bt_cancle  更改为👪购物车
        bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cancle.frame = CGRectMake(80, bt_sure.bottom +10,whiteView.frame.size.width-160, 40);
        [bt_cancle setBackgroundColor:[UIColor whiteColor]];
        [bt_cancle setTitleColor:RGBA(240, 218, 81, 1) forState:0];
        bt_cancle.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt_cancle setTitle:@"加入购物车" forState:0];
        bt_cancle.layer.cornerRadius = 6;
        bt_cancle.layer.borderWidth = 1.5f;
        bt_cancle.layer.borderColor = RGBA(240, 218, 81, 1).CGColor;
        [bt_cancle addTarget:self action:@selector(MerchOrButte:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:bt_cancle];
        
        
        
        //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
        mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
        mainscrollview.showsHorizontalScrollIndicator = NO;
        mainscrollview.showsVerticalScrollIndicator = NO;
        [whiteView addSubview:mainscrollview];
        //购买数量的视图
        countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
        [mainscrollview addSubview:countView];
        [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        countView.tf_count.delegate = self;
        [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        
        
    
        self.bounds = CGRectMake(0, 0, self.frame.size.width, bt_cancle.y+70);
        whiteView.contentSize = CGSizeMake(0, bt_cancle.y+50);
        
    }
    return self;
}

#pragma 加入购物车和立即购买环节
-(void)MerchOrButte:(UIButton *)seder{
    
    [self.deleteagte btnMerchOrButte:seder];
}

-(void)add
{
    int count =[countView.tf_count.text intValue];
    countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    NSLog(@"count=======%@",countView.tf_count.text);
    
}
-(void)reduce
{
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }
    NSLog(@"count=======%@",countView.tf_count.text);
    
}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
        [self tap];
    }
    NSLog(@"count=======%@",countView.tf_count.text);
    
    
}
-(void)tap
{
    mainscrollview.contentOffset = CGPointMake(0, 0);
    [countView.tf_count resignFirstResponder];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
