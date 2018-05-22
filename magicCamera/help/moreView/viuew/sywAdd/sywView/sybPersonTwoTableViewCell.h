//
//  sybPersonTwoTableViewCell.h
//  magicCamera
//
//  Created by jianpan on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SongBtnDetaleagte<NSObject>
-(void)SongBtnPerson:(UIButton *)sender;
@end

@interface sybPersonTwoTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,assign)id<SongBtnDetaleagte>deletagte;
@end
