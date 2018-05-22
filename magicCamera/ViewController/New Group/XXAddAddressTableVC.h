//
//  XXAddAddressTableVC.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXAddModel.h"


//typedef void(^addBlock)(XXAddModel * addmodel);

@interface XXAddAddressTableVC : XXBaseTableViewController

@property (nonatomic, copy) void(^addressBlock)(XXAddModel * addmodel);

@end
