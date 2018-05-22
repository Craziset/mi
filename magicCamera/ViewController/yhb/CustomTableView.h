//
//  CustomTableView.h
//  miliu
//
//  Created by hibo on 2017/11/15.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import <UIKit/UIKit.h>

//自定义tableview
typedef void(^resultsBlock)(NSInteger index, id result);

@interface CustomTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *boardImgArr;

-(instancetype)initWithFrame:(CGRect)frame result:(resultsBlock)block;
@end

@interface BaseCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
-(void)setTitle:(NSString *)title;
@end
