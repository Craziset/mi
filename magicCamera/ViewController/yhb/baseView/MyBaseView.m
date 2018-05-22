//
//  MyBaseView.m
//  Rezhuo
//
//  Created by rzkj on 16/3/20.
//  Copyright © 2016年 rzkj. All rights reserved.
//

#import "MyBaseView.h"
#import "Masonry.h"

/****************************颜色*********************************/
#define RGB(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//cell 分割线
#define separatorCellColor  RGB(220,220,220)//主色调


static MyBaseView *mybaseView = nil;
@implementation MyBaseView


-(id)shareMyBaseView{
    @synchronized(self) {
        if (mybaseView==nil) {
            mybaseView = [[MyBaseView alloc] init];
        }
        
    }
    return mybaseView;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (mybaseView==nil) {
        mybaseView = [super allocWithZone:zone];
    }
    return mybaseView;
}
-(id)copyWithZone:(NSZone *)zone{
    return mybaseView;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return mybaseView;
}

+(UILabel *)myLabelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color backgroudColor:(UIColor *)backgourdColor font:(UIFont *)font{
    UILabel *myLabel  = [[UILabel alloc] initWithFrame:frame];//设置位置大小
    myLabel.text      = text;//设置文字
    myLabel.textColor = color;//设置颜色
    if (backgourdColor!=nil) {
        myLabel.backgroundColor = backgourdColor;//设置背景色
    }
    myLabel.font = font;//设置字体大小
    return myLabel;//返回mylabel对象
}
+(CustomButton *)myButtonFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color backgroudColor:(UIColor *)backgroudColor font:(UIFont *)font{
    CustomButton *myButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    myButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    myButton.frame = frame;
    [myButton setTitle:text forState:UIControlStateNormal];
    if (backgroudColor!=nil) {
        myButton.backgroundColor = backgroudColor;//设置背景色
    }
    if(color!=nil){
        [myButton setTitleColor:color forState:UIControlStateNormal];
    }
    myButton.titleLabel.font = font;
    return myButton;
}
//tableview
+(UITableView*)myTableViewFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate{
    UITableView *tableview = [[UITableView alloc] initWithFrame:frame style:style];
    if (delegate) {
        tableview.delegate = delegate;
        tableview.dataSource = delegate;
    }
    tableview.scrollsToTop   = YES;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.tableFooterView = [[UITableView alloc] init];
    tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableview.rowHeight = 40;
    tableview.separatorColor = separatorCellColor;
    //cell线条
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return tableview;
}
//segment
+(UISegmentedControl*)mySegmentItems:(NSArray*)Items TColor:(UIColor *)color1 sTextColor:(UIColor *)color2 font:(UIFont *)font1 selectFont:(UIFont*)font2{
    UISegmentedControl *segmentC = [[UISegmentedControl alloc] initWithItems:Items];
    segmentC.tintColor = [UIColor clearColor];
    [segmentC setTitleTextAttributes:@{NSFontAttributeName:font1,NSForegroundColorAttributeName:color1} forState:UIControlStateNormal];
    [segmentC setTitleTextAttributes:@{NSFontAttributeName:font2,NSForegroundColorAttributeName:color2} forState:UIControlStateSelected];
    return segmentC;
}
//scrollview
+(UIScrollView*)myScrollViewFrame:(CGRect)frame delegate:(id)delegate{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:frame];
    scrollview.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    scrollview.bounces = YES;
    scrollview.backgroundColor = [UIColor  clearColor];
    scrollview.showsHorizontalScrollIndicator = YES;
    scrollview.showsVerticalScrollIndicator = NO;
    if (delegate!=nil) {
        scrollview.delegate = delegate;
    }
    return scrollview;
}
//创建容器
+(NSArray*)creactContainerNum:(int)num height:(CGFloat)height width:(CGFloat)width step:(CGFloat)step view:(UIView*)view{
    UIView *curView;
    NSMutableArray *viewArr= [NSMutableArray array];
    for (int i=0; i<num; i++) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        [view addSubview:v];
        [v mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, height));
            make.left.mas_equalTo(view.mas_left);
            if (i==0) {
                make.top.mas_equalTo(view.mas_top);
            }else{
                make.top.mas_equalTo(curView.mas_bottom).offset(step);
            }
        }];
        curView = v;
        [curView layoutIfNeeded];
        [viewArr addObject:v];
    }
    return viewArr;
}





@end
