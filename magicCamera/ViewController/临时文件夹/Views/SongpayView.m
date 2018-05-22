//
//  SongpayView.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongpayView.h"
@implementation SongpayView
-(instancetype)initWithFrame:(CGRect)frame withStr:(NSString *)str
{
    _Price =[NSString stringWithFormat:@"￥ %@",str];
    _btnArr = [NSMutableArray arrayWithCapacity:0];
    _arr = @[@"支付方式",@"支付宝",@"微信支付"];
    _arrlmag = @[@"pay_Alipay_icon",@"pay_wechat_icon"];
    self = [super initWithFrame:frame];
    if (self) {
        //半透明视图
        self.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.2];
       self.payTab  =[[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT-250, WIDTH, 250) style:UITableViewStyleGrouped];
        self.payTab.delegate = self;
        self.payTab.dataSource = self;
        self.payTab.backgroundColor = BackColor;
        _payTab.estimatedSectionHeaderHeight =  0.0f;
        [self addSubview:_payTab];
    }
    return self;
}
//-(UITableView *)payTab{
//    if (_payTab == nil) {
//
//    }
//    return _payTab;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 35;
   
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 60.0f;
    }else{
        return 10.0f;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 60)];
        view.backgroundColor  = BackColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(70, 20, WIDTH-140, 35);
        [btn setBackgroundColor:RGBA(246, 212, 56, 1)];
        [btn setTitle:@"确定" forState:0];
        [btn setTintColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(PayConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 7.0f;
        
        [view addSubview:btn];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identener = @"sogcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identener];
    cell.selectionStyle = UITableViewCellStyleDefault;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identener];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = _arr[indexPath.row];
        if (indexPath.row == 0) {
            cell.textLabel.textColor = [UIColor grayColor];
        }else{
            CGSize itemSize = CGSizeMake(25, 25);//固定图片大小为15*15
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            UIImage *icon = [UIImage imageNamed:_arrlmag[indexPath.row-1]];
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
            UIGraphicsEndImageContext();//*3

            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(WIDTH-30, 10, 15, 15);
            [btn setImage:[UIImage imageNamed:@"shop_deselect"] forState:UIControlStateNormal];
            btn.tag = indexPath.row-1;
            [_btnArr addObject:btn];
            [cell addSubview:btn];
        }
    }else if (indexPath.section==0){
        cell.textLabel.text = @"应付金额";
        UILabel *PriceLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100, 0,80 , 40)];
        PriceLab.font = [UIFont systemFontOfSize:15];
        PriceLab.textColor = [UIColor redColor];
        PriceLab.textAlignment = NSTextAlignmentRight;
        PriceLab.text = _Price;
        [cell addSubview:PriceLab];
    }
    return cell;
}
-(void)PayConfirmBtn{
    [self.deleagte PayBtn:_tagStr];
    [self dissMis];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row==0) {
        }else{
            for (UIButton *sender in _btnArr) {
                [sender setImage:[UIImage imageNamed:@"shop_deselect"] forState:UIControlStateNormal];
            }
            [_btnArr[indexPath.row-1] setImage:[UIImage imageNamed:@"logistics_select"] forState:UIControlStateNormal];
            _tagStr = [NSString stringWithFormat:@"%ld",indexPath.row-1];
        }
    }
}

-(void)pop{
    
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    
}
-(void)dissMis{
    NSArray *results = [self subviews];
    for (UIView *view in results) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration: 0.35 animations: ^{
        [self dissMis];
    } completion: nil];
   
    
}

@end
