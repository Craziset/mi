//
//  BaseMoveView.h
//  MoveLabel
//
//  Created by 温春宇 on 16/7/26.
//  Copyright © 2016年 wcy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBorderView.h"


@interface BaseMoveView : LBorderView

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
