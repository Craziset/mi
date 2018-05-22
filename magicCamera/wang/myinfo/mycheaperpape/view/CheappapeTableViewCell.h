//
//  CheappapeTableViewCell.h
//  magicCamera
//
//  Created by Myself on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXCouponModel;

@interface CheappapeTableViewCell : UITableViewCell
@property (nonatomic, strong) XXCouponModel *model;
@property (weak, nonatomic) IBOutlet UILabel *actitynameLab;//活动标题
@property (weak, nonatomic) IBOutlet UILabel *activitytype;//活动内容
@property (weak, nonatomic) IBOutlet UILabel *activitytime;
@property (weak, nonatomic) IBOutlet UILabel *zhekouLab;//折扣
@property (weak, nonatomic) IBOutlet UILabel *zigeLab;//满多少用
- (IBAction)uuseBtn:(id)sender;

@end
