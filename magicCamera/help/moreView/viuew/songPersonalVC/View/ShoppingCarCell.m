//
//  ShoppingCarCell.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UIViewExt.h"
@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)];
    [self.checkBtn setImage:[UIImage imageNamed:@"shop_deselect"] forState:(UIControlStateNormal)];
    [self.checkBtn setImage:[UIImage imageNamed:@"shop_select"] forState:UIControlStateSelected];
    [self addSubview:self.checkBtn];
    [self.checkBtn addTarget:self action:@selector(clickCheckBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkBtn.right+10,15, 65, 75)];
    self.shopImageView.image = [UIImage imageNamed:@"change_pic1_select"];
    self.shopImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.shopImageView];
    

    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,self.shopImageView.top-5,SCR_WIDTH-self.shopImageView.right-20-self.priceLab.width, 20)];
    self.shopNameLab.text = @"合生元金装3段1-3岁";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font =  [UIFont systemFontOfSize:16];
    [self addSubview:self.shopNameLab];
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,self.shopNameLab.bottom,self.shopNameLab.width, 40)];
    self.shopTypeLab.textColor = [UIColor darkGrayColor];
    self.shopTypeLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.shopTypeLab];

    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10, self.shopImageView.bottom-15, 80, 20)];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.textAlignment = NSTextAlignmentLeft;
    self.priceLab.text = @"￥123.00";
    self.priceLab.font =  [UIFont systemFontOfSize:16];
    [self addSubview:self.priceLab];


    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(self.right-100, self.shopImageView.bottom-15, 93, 26)];
    self.addNumberView.delegate = self;
    [self addSubview:self.addNumberView];
    
}

/**
 * 点击减按钮数量的减少
 *
 * @param sender 减按钮
 */
- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"减按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
      
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选中商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
/**
 * 点击加按钮数量的增加
 *
 * @param sender 加按钮
 */
- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"加按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
       
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选中商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    _shoppingModel = shoppingModel;
    self.shopNameLab.text = shoppingModel.product_temp_name;
    
    self.selectState = shoppingModel.is_select;
    self.checkBtn.selected = self.selectState;
    self.checkBtn.selected = self.selectState;
    
    self.shopTypeLab.text  = shoppingModel.size_name;
    
    self.priceLab.text = shoppingModel.preferential_price;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shoppingModel.thumbnail[0]]];

    self.addNumberView.numberString = [NSString stringWithFormat:@"%ld",shoppingModel.quantity];
}


- (void)clickCheckBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(goodsCell:andSelect:)]) {
        [self.delegate goodsCell:self andSelect:btn.selected];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
