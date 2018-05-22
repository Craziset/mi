//
//  ZZgoumaiViewController.h
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ShoppingModel.h"

@interface ZZgoumaiViewController : sywBaseViewController<PayDelegate>

//yes 购物车
@property (nonatomic, assign) BOOL isVC;

@property (nonatomic, strong) AppDelegate *appdele;

@property (weak, nonatomic) IBOutlet UITableView *goumaiTableView;

@property (nonatomic, strong) ShoppingModel *productModel;
@property (nonatomic, strong) NSArray *shopModelArray;
@property (nonatomic, copy) NSString *allPrice;

@end
