//
//  sybPersonTwoTableViewCell.m
//  magicCamera
//
//  Created by jianpan on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "sybPersonTwoTableViewCell.h"

@implementation sybPersonTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    NSArray *arr = @[@"me_pay_default",@"me_delivery_default",@"me_receive_default",@"me_service_default"];
    NSArray *arr1 = @[@"待付款",@"待发货",@"待收货",@"售后"];
    if (self) {
        for (int i = 0; i<arr.count; i++) {
            _bgView = [[UIView alloc]initWithFrame:CGRectMake( WIDTH/4*i, 80*HEIGHT/kWJHeightCoefficient/12, WIDTH/4, 80)];
            _btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat h;
            if (SCR_WIDTH > 400)
            {
                h = _bgView.frame.size.height - 30;
            }else
            {
                h = _bgView.frame.size.height - 40;
            }
            _btn.frame = CGRectMake(20, 15, _bgView.frame.size.width - 40, h);
            _btn.contentMode = UIViewContentModeScaleAspectFit;
            [_btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            
            _btn.tag = i;
            [_btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
            _lab = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_btn.frame),_bgView.frame.size.width, 20)];
            _lab.text = arr1[i];
            _lab.font = [UIFont systemFontOfSize:13];
            _lab.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_bgView];
            [_bgView addSubview:_btn];
            [_bgView addSubview:_lab];
        }
    }
    return self;
}
-(void)btnEvent:(UIButton *)semder{
    [self.deletagte SongBtnPerson:semder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
