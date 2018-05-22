//
//  ZZgoumaiViewController.h
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZgoumaiViewController : sywBaseViewController

//yes 购物车
@property (nonatomic, assign) BOOL isVC;


@property (weak, nonatomic) IBOutlet UITableView *goumaiTableView;
@property(nonatomic,strong)UIImage *selectImage;//商品的图片
@property(nonatomic,strong)NSString *ZiseStr;//商品的尺码
@property(nonatomic,strong)NSString *ColorStr;//商品颜色
@property(nonatomic,strong)NSString *CountStr;//商品的数量
@property (nonatomic, copy) NSString *product_id; //产品id
@property(strong,nonatomic)NSDictionary *NextproductDic; //产品的信息
@property (nonatomic, copy) NSString *allPrice;

@end
