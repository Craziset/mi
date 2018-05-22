//
//  firstTableViewCell.m
//  ww
//
//  Created by zxgy on 2017/11/16.
//  Copyright © 2017年 zxgy. All rights reserved.
//

#import "firstTableViewCell.h"

@implementation firstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.usericon.layer.cornerRadius=25.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
