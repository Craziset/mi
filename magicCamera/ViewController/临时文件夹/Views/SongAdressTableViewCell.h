//
//  SongAdressTableViewCell.h
//  magicCamera
//
//  Created by 宋建 on 2017/11/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXAddModel;

typedef void(^cellBlock)();

@interface SongAdressTableViewCell : UITableViewCell
@property (nonatomic, copy) cellBlock clickBlock;
@property (nonatomic, strong) XXAddModel *addModel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@property (weak, nonatomic) IBOutlet UIButton *changebtn;

@end
