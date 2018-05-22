//
//  MyBaseView.h
//  Rezhuo
//
//  Created by rzkj on 16/3/20.
//  Copyright © 2016年 rzkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface MyBaseView : UIView<NSCopying,NSMutableCopying>
//设置为单例
-(id)shareMyBaseView;

@property(nonatomic,assign)BOOL flag;

//创建label对象
+(UILabel*)myLabelFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color backgroudColor:(UIColor*)color font:(UIFont*)font;
//创建button对象
+(CustomButton *)myButtonFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color backgroudColor:(UIColor*)color font:(UIFont*)font;
//创建tableiview对象
+(UITableView*)myTableViewFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate;
//scrollview
+(UIScrollView*)myScrollViewFrame:(CGRect)frame delegate:(id)delegate;
//创建容器
+(NSArray*)creactContainerNum:(int)num height:(CGFloat)height width:(CGFloat)width step:(CGFloat)step view:(UIView*)view;

//segment
+(UISegmentedControl*)mySegmentItems:(NSArray*)Items TColor:(UIColor *)color1 sTextColor:(UIColor *)color2 font:(UIFont *)font1 selectFont:(UIFont*)font2;


@end
