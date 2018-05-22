//
//  ZZsetnewTableViewCell.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZsetnewTableViewCell.h"

@implementation ZZsetnewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)clickSwitchBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end
