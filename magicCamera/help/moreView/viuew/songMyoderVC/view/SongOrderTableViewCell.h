//
//  SongOrderTableViewCell.h
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongOrderTablemodel.h"

@interface SongOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) SongOrderTablemodel *model;

@property(nonatomic,strong)UIImageView *atvorImg;

@property(nonatomic,strong)UILabel *NameLab;

@property(nonatomic,strong)UILabel *PriceLab;

@property(nonatomic,strong)UILabel *ColorLab;

@property(nonatomic,strong)UILabel *NumberLab;


-(void)configureCellWithModel:(SongOrderTablemodel *)Electimage;

@end
