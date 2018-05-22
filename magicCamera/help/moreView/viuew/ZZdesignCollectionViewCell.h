//
//  ZZdesignCollectionViewCell.h
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySourceModel;

typedef void(^collBlock)(NSInteger iii);

@interface ZZdesignCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MySourceModel *model;
@property (nonatomic, copy) collBlock  cellBlock;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *downlabel;
@property (weak, nonatomic) IBOutlet UIButton *sharBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;


@end
