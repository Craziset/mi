//
//  ChoseView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
#import "SongColorView.h"
// 添加加入购物车人和立即购买点击事件
@protocol MerchOrButteDetelagte<NSObject>
-(void)btnMerchOrButte:(UIButton *)btn;

@end
@interface ChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIScrollView *whiteView;

@property(nonatomic, retain)UILabel *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)TypeView *sizeView;
@property(nonatomic, retain)SongColorView *colorView;
@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic) int stock;

@property(nonatomic,assign)id<MerchOrButteDetelagte>deleteagte;


@end
