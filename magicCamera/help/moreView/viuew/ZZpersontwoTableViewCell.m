//
//  ZZpersontwoTableViewCell.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZpersontwoTableViewCell.h"

@implementation ZZpersontwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)PayeringBtn:(id)sender {
    
    
    [self tapBtn:1];
    
}

- (IBAction)DeviveBtn:(id)sender {
    
    [self tapBtn:2];
}
- (IBAction)FaHuoBtn:(id)sender {
    
    
    [self tapBtn:3];

}
- (IBAction)SeriveBtn:(id)sender {
    
    [self tapBtn:4];

}
-(void)tapBtn:(NSInteger)tag{
    [self.deleagte tapZZpersontwoTableViewCell:tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
