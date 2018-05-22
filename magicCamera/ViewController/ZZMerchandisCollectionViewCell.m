//
//  ZZMerchandisCollectionViewCell.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZMerchandisCollectionViewCell.h"
#import "ZZCustomZoneModel.h"
#import "ZZProductTempModel.h"
@implementation ZZMerchandisCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)configureCellWithModel:(ProductModel *)ExhbitMode{
    ZZProductTempModel *colorModel = ExhbitMode.colors[0];
   
    ZZCustomZoneModel *zoneMeol = colorModel.temp_custom_zones[0];
    [self.imageMerchandisCollection sd_setImageWithURL:[NSURL URLWithString:zoneMeol.thumbnail] placeholderImage:[UIImage imageNamed:@"common_nopic"]];

    self.upLebel.text = ExhbitMode.name;
    self.downLabel.text = ExhbitMode.default_price;
    
}
@end
