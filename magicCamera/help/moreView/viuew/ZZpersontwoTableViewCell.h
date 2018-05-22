//
//  ZZpersontwoTableViewCell.h
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZpersontwoTableViewCellTapDelegate <NSObject>
- (void)tapZZpersontwoTableViewCell:(NSUInteger)tag;
@end

@interface ZZpersontwoTableViewCell : UITableViewCell

@property(nonatomic,assign)id<ZZpersontwoTableViewCellTapDelegate >deleagte;

@end
