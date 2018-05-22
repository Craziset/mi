//
//  ZZdesignCollectionViewCell.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZdesignCollectionViewCell.h"
#import "MySourceModel.h"

@implementation ZZdesignCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MySourceModel *)model {
    _model = model;
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage: [UIImage imageNamed:@"common_nopic"]];
    
    if ([XXJudgment stringWithNill:_model.source_pic_name] ) {
        self.upLabel.text = model.name;
    }else {
         self.upLabel.text = model.source_pic_name;
    }
    
    self.downlabel.text = @"2018-01-12";
    
}

- (IBAction)clickDelete:(UIButton *)sender {
    if (_cellBlock) {
        self.cellBlock(1);
    }
}

- (IBAction)clickShar:(UIButton *)sender {
    if (_cellBlock) {
        self.cellBlock(0);
    }
}

@end
