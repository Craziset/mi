//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
// 过期提醒

@class MJRefreshHeader, MJRefreshLegendHeader,MJRefreshHeader;
@class MJRefreshGifHeader,MJRefreshLegendFooter, MJRefreshFooter;

@interface UIScrollView (MJRefresh)

@property (strong, nonatomic) MJRefreshHeader *mj_header;
@property (strong, nonatomic) MJRefreshHeader *header MJRefreshDeprecated("mj_header");
/** gif功能的下拉刷新控件 */

@property (nonatomic, readonly)MJRefreshGifHeader *gifHeader;

@property (strong, nonatomic) MJRefreshFooter *mj_footer;
@property (strong, nonatomic) MJRefreshFooter *footer MJRefreshDeprecated("mj_footer");
@property (copy, nonatomic) void (^mj_reloadDataBlock)(NSInteger totalDataCount);

- (NSInteger)mj_totalDataCount;

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback MJDeprecated("建议使用addLegendHeaderWithRefreshingBlock:");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithCallback:(void (^)())callback dateKey:(NSString*)dateKey MJDeprecated("建议使用addLegendHeaderWithRefreshingBlock:dateKey:");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action MJDeprecated("建议使用addLegendHeaderWithRefreshingTarget:refreshingAction:");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey MJDeprecated("建议使用addLegendHeaderWithRefreshingTarget:refreshingAction:dateKey:");

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing MJDeprecated("建议使用[self.tableView.header beginRefreshing]");

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing MJDeprecated("建议使用[self.tableView.header endRefreshing]");

/**
 *  下拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden MJDeprecated("建议使用self.tableView.header.hidden");

/**
 *  是否正在下拉刷新
 */
@property (nonatomic, assign, readonly, getter = isHeaderRefreshing) BOOL headerRefreshing MJDeprecated("建议使用self.tableView.header.isRefreshing");

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback MJDeprecated("建议使用addLegendFooterWithRefreshingBlock:");

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action MJDeprecated("建议使用addLegendFooterWithRefreshingTarget:refreshingAction:");

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing MJDeprecated("建议使用[self.tableView.footer beginRefreshing]");

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing MJDeprecated("建议使用[self.tableView.footer endRefreshing]");

/**
 *  上拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden MJDeprecated("建议使用self.tableView.footer.hidden");

/**
 *  是否正在上拉刷新
 */
@property (nonatomic, assign, readonly, getter = isFooterRefreshing) BOOL footerRefreshing MJDeprecated("建议使用self.tableView.footer.isRefreshing");





@end
