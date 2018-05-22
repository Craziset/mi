//
//  XXCitysTableViewController.h
//  XXTableView
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 corepass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXAreasTableViewController;

@interface XXCitysTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *citis;
@property (nonatomic, copy) NSString *provinceStr;

@property (nonatomic, strong) XXAreasTableViewController *areasVC;

@end
