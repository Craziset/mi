//
//  ZZOuTongTableViewCell.h
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZOuTongTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *youhuiquanlabel;
@property (weak, nonatomic) IBOutlet UILabel *fapiaoxinxi;
@property (weak, nonatomic) IBOutlet UILabel *nofapiao;
@property (weak, nonatomic) IBOutlet UIButton *peisongLabel;
@property (weak, nonatomic) IBOutlet UITextField *RamkarText;

/**
 商品金额
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

/**
 运费
 */
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@end
