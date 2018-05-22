//
//  ZZoneadressTableViewCell.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZoneadressTableViewCell.h"
#import "XXAddModel.h"

@implementation ZZoneadressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

//    [_SelateBtn setBackgroundImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
//     [_SelateBtn setBackgroundImage:[UIImage imageNamed:@"address_deselect"] forState:UIControlStateSelected];
//    [_SelateBtn addTarget:self action:@selector(SelateBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
//    _eidtBtn.layer.borderWidth = 1.0f;
//    _eidtBtn.layer.borderColor = RGBA(240, 218, 81, 1).CGColor;
//    
//    _deleteBtn.layer.borderWidth = 1.0f;
//    _deleteBtn.layer.borderColor = RGBA(240, 218, 81, 1).CGColor;
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = RGBA(240, 218, 81, 1).CGColor;
    self.layer.cornerRadius = 10.0f;
    
}

-(void)SelateBtnEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddModel:(XXAddModel *)addModel
{
    _addModel = addModel;
    self.RevicePersonLab.text = _addModel.consignee;
    self.AdresssLab.text =[NSString stringWithFormat:@"%@%@",_addModel.complete_city_info,_addModel.address];
    self.phoneLabel.text = _addModel.phone;
}

//选中
- (IBAction)clickSelected:(UIButton *)sender {
    sender.selected = YES;
    
    if (self.addblock) {
        self.addblock(1);
    }
}
//删除
- (IBAction)clickDelete:(UIButton *)sender {
    if (self.addblock) {
        self.addblock(2);
    }
}
//编辑
- (IBAction)clickEdit:(UIButton *)sender {
    if (self.addblock) {
        self.addblock(3);
    }
    
}
@end
