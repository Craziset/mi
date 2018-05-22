//  MJRefreshHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.

#import "MJRefreshComponent.h"
typedef enum {
    /** 普通闲置状态 */
    MJRefreshHeaderStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    MJRefreshHeaderStatePulling,
    /** 正在刷新中的状态 */
    MJRefreshHeaderStateRefreshing,
    /** 即将刷新的状态 */
    MJRefreshHeaderStateWillRefresh
} MJRefreshHeaderState;

@interface MJRefreshHeader : MJRefreshComponent

+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

#pragma mark - 文字控件的可见性处理
/** 是否隐藏状态标签 */
@property (assign, nonatomic, getter=isStateHidden) BOOL stateHidden;
/** 是否隐藏刷新时间标签 */
@property (assign, nonatomic, getter=isUpdatedTimeHidden) BOOL updatedTimeHidden;


@end
