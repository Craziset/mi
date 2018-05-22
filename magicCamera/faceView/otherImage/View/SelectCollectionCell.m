//
//  SelectCollectionCell.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/8.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SelectCollectionCell.h"

@implementation SelectCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 2.5f;
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
