//
//  HeaderColumView.h
//  MaskDemo
//
//  Created by xumingfa on 16/2/29.
//  Copyright © 2016年 xumingfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMFSegmentView;

@protocol XMFSegmentViewDataSource <NSObject>

//  item的宽度
@required
- (CGFloat)segmentView : (XMFSegmentView *)segmentView widthOfIndex: (NSUInteger) index;

//  标题
- (NSString *)segmentView: (XMFSegmentView *)segmentView titleOfIndex: (NSUInteger) index;

//  item的数量
- (NSUInteger)numberOfItemsInSegmentView : (XMFSegmentView *)segmentView;

@optional
//  高亮颜色（默认是红色）
- (UIColor *)highlightColorInSegmentView : (XMFSegmentView *)segmentView;

//  字体颜色 （默认是白色）
- (UIColor *)fontColorInSegmentView : (XMFSegmentView *)segmentView;

@end

@protocol XMFSegmentViewDelegate <NSObject>

@optional
//  点击按事件
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex: (NSUInteger) index;

@end

@interface XMFSegmentView : UIScrollView

@property (nonatomic, assign) id<XMFSegmentViewDataSource> dataSource;

@property (nonatomic, assign) id<XMFSegmentViewDelegate> columDelegate;

@property (nonatomic, strong)  NSMutableArray<NSString *> *titleArray;

@property (nonatomic, assign) NSUInteger defaultIndex; //  设置默认位置

+ (instancetype)createColumViewWithDefaultIndex : (NSUInteger) index;

@end
