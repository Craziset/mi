//
//  ZZMerchandisCollectionViewCell.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "QuartView.h"
@interface ZZMerchandisCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageMerchandisCollection;
@property (weak, nonatomic) IBOutlet UILabel *upLebel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;
-(void)configureCellWithModel:(ProductModel *)ExhbitMode;
@property (weak, nonatomic) IBOutlet QuartView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *orgImage;

@end
