//
//  CheappapeTableViewCell.m
//  magicCamera
//
//  Created by Myself on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "CheappapeTableViewCell.h"
#import "XXCouponModel.h"
@implementation CheappapeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.activitytype.layer.cornerRadius=5.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(XXCouponModel *)model
{
    _model = model;
    self.actitynameLab.text = _model.name;
    self.activitytype.text = _model.desc;
    self.activitytime.text = [NSString stringWithFormat:@"有效期%@",model.time_str];
//    self.zhekouLab.text = _model.price;
    NSArray *array = [_model.price componentsSeparatedByString:@"."];
    if (array.count>0) {
        self.zigeLab.text = [NSString stringWithFormat:@"满%@元可用", array[0]];
    }else
    {
        self.zigeLab.text = [NSString stringWithFormat:@"满%@元可用", _model.price];
    }
    
}

- (IBAction)uuseBtn:(id)sender {
    
}
@end
