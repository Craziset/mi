//
//  SongFootView.h
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//  尾视图

#import <UIKit/UIKit.h>
#import "SongHeadmodel.h"
@interface SongFootView : UITableViewHeaderFooterView

@property(nonatomic,strong)UILabel *totalCountLab;

@property(nonatomic,strong)UIButton *FirstGoundBtn;

@property(nonatomic,strong)UIButton *FirstGoundBtn1;

@property(nonatomic,strong)UIButton *StusBtn1;

@property(nonatomic,strong)UIButton *StusBtn2;

-(void)configureCellWithModel:(SongHeadmodel *)ExhbitMode;

@end
