//
//  XXRectView.h
//  magicCamera
//
//  Created by 徐征 on 2018/3/7.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "LBorderView.h"

@interface XXRectView : LBorderView

@property (nonatomic, copy) void(^frameBlock)(CGSize size);
@property (nonatomic, assign) BOOL isShowLine;

/**
 remove拖拽View
 */
- (void)removeSetupUI;

- (void)setupUI2;

- (void)resetAllArrows;

- (void)showLine;

- (void)hiddenLine;

@end
