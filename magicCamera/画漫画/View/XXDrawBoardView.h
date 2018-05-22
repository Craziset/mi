//
//  XXDrawView.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/27.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XXDrawBoardView : UIView

@property (nonatomic,strong) UIColor *strokeColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, getter=isErasing) BOOL erasing;

@property (nonatomic,assign) BOOL stateFlag;//YES 可以画画 NO 不允许


@end
