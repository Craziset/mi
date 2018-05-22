//
//  SongFootView.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongFootView.h"
@implementation SongFootView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _totalCountLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, WIDTH-10, 25)];
        _totalCountLab.text = @"共计 1 件商品 实付 （含运费）¥ 79.00";
        _totalCountLab.textAlignment = NSTextAlignmentRight;
        _totalCountLab.textColor  = [UIColor colorWithHexString:@"#333333"];
        _totalCountLab.font  = [UIFont systemFontOfSize:15];
        
        NSArray *arr = @[@"order_service_default",@"order_delete_default"];
        _FirstGoundBtn  =[[UIButton alloc]initWithFrame:CGRectMake(8+70*0, _totalCountLab.bottom+10, 27, 27)];
        _FirstGoundBtn.layer.cornerRadius = 4;
        [_FirstGoundBtn setImage:[UIImage imageNamed:arr[0]] forState:UIControlStateNormal];
        [_FirstGoundBtn setTitle:@"1" forState:UIControlStateNormal];
        _FirstGoundBtn.layer.borderWidth = 1;
        _FirstGoundBtn.layer.borderColor = BackColor.CGColor;
        _FirstGoundBtn.layer.cornerRadius = 4;
        [self addSubview:_FirstGoundBtn];
        
        
        _FirstGoundBtn1  =[[UIButton alloc]initWithFrame:CGRectMake(_FirstGoundBtn.right+5, _totalCountLab.bottom+10, 27, 27)];
        _FirstGoundBtn1.layer.cornerRadius = 4;
        [_FirstGoundBtn1 setImage:[UIImage imageNamed:arr[1]] forState:UIControlStateNormal];
        _FirstGoundBtn1.layer.borderWidth = 1;
        _FirstGoundBtn1.layer.borderColor = BackColor.CGColor;
        _FirstGoundBtn1.layer.cornerRadius = 4;
        [self addSubview:_FirstGoundBtn1];
        
        
        _StusBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-70, _totalCountLab.bottom+10, 65, 30)];
        _StusBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_StusBtn1];
        
        
        _StusBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(_StusBtn1.frame)-75, _totalCountLab.bottom+10, 65, 30)];
        _StusBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_StusBtn2];
        [self addSubview:_totalCountLab];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 5)];
        view.backgroundColor = BackColor;
        [self addSubview:view];
        
    }
    return self;
}
// 这里将头试图和脚试图的数据放在一起，请注意！！！
-(void)configureCellWithModel:(SongHeadmodel *)ExhbitMode{
    /*@anthuor：song
      reason：由于后台数据不完善，这里的tagStatus是从主页面传方法传递过来的，这个时候暂定
      time：2017.11.14
      规则-tagStatus：0 全部   1 代付款 2 代发货 3代收货  4售后
    */
    _totalCountLab.text = [NSString stringWithFormat:@"共计 %@ 件商品 实付 （含运费）¥ %.2f",ExhbitMode.Ordergood_total_quantityStr, [ExhbitMode.Ordertotal_priceStr  floatValue]];
    switch ([ExhbitMode.OrderStateStr integerValue]) {
        case 0:
        {
            // 这里是全部订单，需要根据订单的状态才能进行查看
            
        }break;
        case 1:
        {    //代付款
            _StusBtn2.hidden = NO;
            _StusBtn1.hidden = NO;
            _FirstGoundBtn1.hidden = NO;
            [_StusBtn2 setTitle:@"取消"  forState:UIControlStateNormal];
            _StusBtn2.layer.borderWidth = 1;
            _StusBtn2.layer.borderColor = RGBA(238, 218, 82, 1).CGColor;
            _StusBtn2.layer.cornerRadius = 4;
            _StusBtn2.backgroundColor =  [UIColor whiteColor];
            [_StusBtn2 setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
            _StusBtn1.layer.cornerRadius = 4;
            [_StusBtn1 setTitle:@"付款"  forState:UIControlStateNormal];
            _StusBtn1.backgroundColor = RGBA(238, 218, 82, 1);
            [_StusBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             _StusBtn1.layer.cornerRadius = 4;
        }break;
        case 2:
        {//待发货
            _StusBtn2.hidden = YES;
            _StusBtn1.hidden = NO;
            _FirstGoundBtn1.hidden = YES;
            [_StusBtn1 setTitle:@"提醒发货"  forState:UIControlStateNormal];
            _StusBtn1.layer.borderWidth = 1;
            _StusBtn1.layer.borderColor = RGBA(238, 218, 82, 1).CGColor;
            _StusBtn1.layer.cornerRadius = 4;
            _StusBtn1.backgroundColor =  [UIColor whiteColor];
            [_StusBtn1 setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
        }break;
        case 3:
        {//待收货
            _StusBtn2.hidden = NO;
            _StusBtn1.hidden = NO;
            _FirstGoundBtn1.hidden = YES;
            [_StusBtn2 setTitle:@"查看物流"  forState:UIControlStateNormal];
            _StusBtn2.layer.borderWidth = 1;
            _StusBtn2.layer.borderColor = RGBA(238, 218, 82, 1).CGColor;
            _StusBtn2.layer.cornerRadius = 4;
            _StusBtn2.backgroundColor =  [UIColor whiteColor];
             [_StusBtn2 setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
            [_StusBtn1 setTitle:@"确认收货"  forState:UIControlStateNormal];
            _StusBtn1.backgroundColor = RGBA(238, 218, 82, 1);
            [_StusBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            
        }break;
        case 4:
        {//售后
            _StusBtn2.hidden = YES;
            _StusBtn1.hidden = NO;
            _FirstGoundBtn1.hidden = YES;
            [_StusBtn1 setTitle:@"查看订单"  forState:UIControlStateNormal];
            _StusBtn1.layer.borderWidth = 1;
            _StusBtn1.layer.borderColor = RGBA(238, 218, 82, 1).CGColor;
            _StusBtn1.layer.cornerRadius = 4;
            _StusBtn1.backgroundColor =  [UIColor whiteColor];
            [_StusBtn1 setTitleColor:RGBA(238, 218, 82, 1) forState:UIControlStateNormal];
        }break;
    }
    
}

@end
