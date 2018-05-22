//
//  SongAdressTableViewCell.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongAdressTableViewCell.h"
#import "XXAddModel.h"

@implementation SongAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_address_frame"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickChangeBtn:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)setAddModel:(XXAddModel *)addModel
{
    _addModel = addModel;
    self.phoneLabel.text = _addModel.phone;
    self.nameLabel.text = _addModel.consignee;
    self.addLabel.text = _addModel.address;
}

@end
