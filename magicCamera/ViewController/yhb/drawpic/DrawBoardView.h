//
//  DrawBoardView.h
//  miliu
//
//  Created by hibo on 2017/11/16.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//画笔属性
@interface Line : NSObject
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat width;

//mine
@property (nonatomic, strong) NSMutableArray *linePoints;
@property (nonatomic, strong) UIColor        *lineColor;
@property (nonatomic, assign) CGFloat         lineWidth;

@property (nonatomic, assign) NSInteger       drawType;
@property (nonatomic, assign) CGSize          drawSize;

@property (nonatomic, assign) CGPoint         startPoint;
@property (nonatomic, assign) CGPoint         lastPoint;


@end

//画板
@interface DrawBoardView : UIView
{
    CGMutablePathRef path;
    NSMutableArray *pathModalArray;
}
@property (nonatomic) Line *currentLine;//当前的线条
@property (nonatomic) UIColor *lineColor;//画笔颜色
@property (nonatomic) CGFloat lineWidth;//线宽
@property (nonatomic,assign) BOOL stateFlag;//YES 可以画画 NO 不允许


@property (nonatomic, getter=isErasing) BOOL erasing;
@property (nonatomic) CGContextRef offscreenContext;
@property (nonatomic) CGPoint lastLocation;
@property (nonatomic) UIColor *strokeColor;


-(void)undoAction;


@end


