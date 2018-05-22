//
//  XXAreasTableViewController.h
//  XXTableView
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 corepass. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XXAreasTableViewController : UITableViewController

@property (nonatomic, copy) void(^addBlock)(NSString *provinceStr ,NSString *cityName,NSString *pcaStr);
@property (nonatomic, copy) NSString *provinceStr;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSArray *areas;


@end
