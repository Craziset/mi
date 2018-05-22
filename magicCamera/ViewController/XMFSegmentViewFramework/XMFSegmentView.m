//
//  HeaderColumView.m
//  MaskDemo
//
//  Created by xumingfa on 16/2/29.
//  Copyright © 2016年 xumingfa. All rights reserved.
//

#import "XMFSegmentView.h"

@interface XMFSegmentView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *datas;

@property (nonatomic, weak) CALayer *highlightLayer;

@property (nonatomic, assign) NSUInteger currtentIndex;

@end

@implementation XMFSegmentView


+ (instancetype)createColumViewWithDefaultIndex:(NSUInteger)index {
    XMFSegmentView *segmentView = [XMFSegmentView new];
    [segmentView setDefaultIndex: index];
    return segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)setDataSource:(id<XMFSegmentViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self bulidView];
}

- (void)setFrame:(CGRect)frame {
    //  高度设置
    CGRect lightframe = self.highlightLayer.frame;
    lightframe.size.height = CGRectGetHeight(frame);
    self.highlightLayer.frame = lightframe;
    
    [super setFrame:frame];
}

#pragma mark 设置默认item
- (void)setDefaultIndex:(NSUInteger)defaultIndex {
    _defaultIndex = defaultIndex;
    
    [self layoutIfNeeded];
    [self moveToHighlightWithButton: self.datas[defaultIndex]];
}

#pragma mark - item初始化
- (void)bulidView {
    
    NSAssert(self.dataSource, @"not dataSource");
    
    NSUInteger count;
    NSAssert([self.dataSource respondsToSelector: @selector(numberOfItemsInSegmentView:)], @"respondsToSelector: @selector(numberOfItemsInSegmentView:) is null");
    count = [self.dataSource numberOfItemsInSegmentView: self]; // item数量
    _datas = [NSMutableArray<UIButton *> arrayWithCapacity: count];
    
    UIColor *fontColor = [UIColor whiteColor];
    if ([self.dataSource respondsToSelector: @selector(fontColorInSegmentView:)]) {
        fontColor = [self.dataSource fontColorInSegmentView:self];
    }
    
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [self createItemWithIndex:i fontColor:fontColor];
        [self.datas addObject: btn];
        [self addSubview: btn];
    }
    
}

#pragma mark 创建高亮背景

#pragma mark 创建按钮
- (UIButton *)createItemWithIndex : (NSUInteger)index fontColor: (UIColor *) color {
    
    UIButton *btn = [UIButton new];
    btn.tag = index;
    NSAssert([self.dataSource respondsToSelector:@selector(segmentView:titleOfIndex:)], @"respondsToSelector:@selector(segmentView:titleOfIndex:) is null");
    
    NSString *title = [self.dataSource segmentView:self titleOfIndex:btn.tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushItemWithButton:) forControlEvents:UIControlEventTouchUpInside];
    if (index == 0) {
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else
    {
        btn.backgroundColor = [UIColor whiteColor];
    }
    return btn;
}

 - (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray
{
    _titleArray = titleArray;
    [self.datas enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:_titleArray[idx] forState:(UIControlStateNormal)];
    }];
    
//    [self.titles enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.text = _titleArray[idx];
//    }];
    
}



#pragma mark 创建标题
- (UILabel *)createTiltleWithIndex : (NSUInteger)index fontColor: (UIColor *) color button : (UIButton *)btn{
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = btn.titleLabel.text;
    titleLabel.font = btn.titleLabel.font;
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    return titleLabel;
}

#pragma mark - item点击事件
- (void)pushItemWithButton : (UIButton *) btn {
    
    _defaultIndex = btn.tag;
   
    [self.datas enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == btn.tag) {
            obj.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else
        {
            obj.backgroundColor = [UIColor whiteColor];
        }

    }];
    
//    [self moveToHighlightWithButton: btn];
    
    if (self.columDelegate && [self.columDelegate respondsToSelector:@selector(segmentView:didSelectItemsAtIndex:)]) {
        [self.columDelegate segmentView:self didSelectItemsAtIndex:btn.tag];
    }
}

#pragma mark - 高亮
- (void)moveToHighlightWithButton : (UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _datas[btn.tag].frame;
        _highlightLayer.frame = frame;
    }];
    
    const CGFloat moveX = [self countMoveXWithItem: btn];
    [self setContentOffset: CGPointMake(moveX, self.contentOffset.y) animated:YES];
}

#pragma mark - item移动算法
- (CGFloat)countMoveXWithItem : (UIButton *) item {
    const CGFloat x = CGRectGetMinX(item.frame);
    
    const CGFloat width = CGRectGetWidth(item.frame);
    
    const CGFloat currtWith = CGRectGetWidth(self.frame);
    
    CGFloat moveX = x - (currtWith - width) / 2;
    
    if (moveX < 0.f) {
        moveX = 0.f;
    }
    else if (moveX > self.contentSize.width - currtWith) {
        moveX = self.contentSize.width - currtWith;
    }
    
    return moveX;
}


#pragma mark item布局
- (void)layoutItems {
    NSAssert([_dataSource respondsToSelector:@selector(segmentView:widthOfIndex:)], @"respondsToSelector:@selector(segmentView:widthOfIndex:) is null");
    
    for (int i = 0; i < _datas.count; i++) {
        UIButton *btn = _datas[i];
        
        const CGFloat x = i == 0 ? 3.f : 3 + (CGRectGetMaxX(_datas[i - 1].frame)+i*2);
        
        const CGFloat width = [_dataSource segmentView:self widthOfIndex:i];
        
        btn.frame = CGRectMake(x, 1.5, width, CGRectGetHeight(self.frame)-3);

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
//        _titles[i].frame = btn.frame;
        
        if (i == _datas.count - 1) {
            self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), self.contentSize.height);
        }
    }
}

- (void)layoutSubviews {
    [self layoutItems];
    
    [super layoutSubviews];
}

@end
