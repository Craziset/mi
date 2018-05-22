//
//  TicketControlViews.h
//  magicCamera
//
//  Created by jianpan on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ticketblock)(NSString *ticketStr);

@interface TicketControlViews : sywBaseViewController

@property (nonatomic, copy) ticketblock block;

@end
