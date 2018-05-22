//  MJRefreshFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.

#import "MJRefreshComponent.h"

typedef enum {
    MJRefreshFooterStateIdle = 1, // 普通闲置状态
    MJRefreshFooterStateRefreshing, // 正在刷新中的状态
    MJRefreshFooterStateNoMoreData // 所有数据加载完毕，没有更多的数据了
} MJRefreshFooterState;


@interface MJRefreshFooter : MJRefreshComponent

+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)endRefreshingWithNoMoreData;
- (void)noticeNoMoreData MJRefreshDeprecated("Please use endRefreshingWithNoMoreData");
- (void)resetNoMoreData;

@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden;

/** 是否隐藏状态标签 */
@property (assign, nonatomic, getter=isStateHidden) BOOL stateHidden;



@end
