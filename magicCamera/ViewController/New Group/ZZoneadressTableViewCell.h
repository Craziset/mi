//
//  ZZoneadressTableViewCell.h
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXAddModel;

typedef void(^cellBlock)(NSInteger select);
typedef void(^selecBlock)(BOOL select);

@interface ZZoneadressTableViewCell : UITableViewCell
@property (nonatomic, strong) XXAddModel *addModel;

@property (nonatomic, copy) cellBlock addblock;
@property (nonatomic, copy) selecBlock addSelecBlock;

@property (weak, nonatomic) IBOutlet UIButton *SelateBtn; //是否选中的图标
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *RevicePersonLab; // 收获人

@property (weak, nonatomic) IBOutlet UILabel *AdresssLab; //收获地址


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn; //删除

@property (weak, nonatomic) IBOutlet UIButton *eidtBtn;  // 编辑

@property (weak, nonatomic) IBOutlet UILabel *LineLab;

- (IBAction)clickSelected:(UIButton *)sender;
- (IBAction)clickDelete:(UIButton *)sender;

- (IBAction)clickEdit:(UIButton *)sender;

@end
