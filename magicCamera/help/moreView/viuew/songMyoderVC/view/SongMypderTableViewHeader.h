//
//  SongMypderTableViewHeader.h
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//  订单列表上的头视图

#import <UIKit/UIKit.h>
#import "SongHeadmodel.h"

@interface SongMypderTableViewHeader : UITableViewHeaderFooterView

@property(nonatomic,strong)UILabel *OderNumberLab;

@property(nonatomic,strong)UILabel *OderTimeLab;

-(void)configureCellWithModel:(SongHeadmodel *)ExhbitMode;

@end
