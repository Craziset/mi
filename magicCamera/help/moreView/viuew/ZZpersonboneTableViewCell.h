//
//  ZZpersonboneTableViewCell.h
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UsericonBlock) (UIButton*userbtn);
@interface ZZpersonboneTableViewCell : UITableViewCell
@property(nonatomic,copy)UsericonBlock usericonblock;
@property (weak, nonatomic) IBOutlet UILabel *usertitle;
- (IBAction)usericonBtn:(id)sender;
@end
