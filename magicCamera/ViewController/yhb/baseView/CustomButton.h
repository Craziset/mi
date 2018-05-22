//
//  CustomButton.h
//  Hotdesk
//
//  Created by rzkj on 16/7/5.
//  Copyright © 2016年 rzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)NSMutableDictionary *dicMtb;
@property (nonatomic,strong)NSString *idStr;
@property (nonatomic,strong)NSString *idStr1;
@property (nonatomic,strong)NSString *idStr2;
@property (nonatomic,assign)int index;//索引
@property (nonatomic,strong)NSString *leveId;//级别
@property (nonatomic,strong)NSArray *idStrArr;
@property (nonatomic,strong)NSMutableArray *mtbArr;
@property (nonatomic,weak)CustomButton *parentButton;
@property (nonatomic,weak)CustomButton *subButton;

@property (nonatomic,assign)NSInteger section;
@property (nonatomic,assign)NSInteger row;

@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;


@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) UIImageView *imageview;

@property (nonatomic,strong) UIView *backView;

-(void)setParentButton:(CustomButton *)parentButton;


@end
