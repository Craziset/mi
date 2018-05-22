//
//  XXDrawView.m
//  magicCamera
//
//  Created by 徐征 on 2018/1/27.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "XXDrawBoardView.h"
#import <QuartzCore/QuartzCore.h>

@interface XXDrawBoardView ()
{
    CGMutablePathRef path;
}
@property (nonatomic) CGContextRef offscreenContext;
@property (nonatomic) CGPoint lastLocation;

@end

@implementation XXDrawBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.strokeColor = [UIColor blackColor];
        self.lineWidth = 5.0;
        self.userInteractionEnabled = YES;
        CGSize viewSize = self.frame.size;
        size_t width = viewSize.width;
        size_t height = viewSize.height;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        self.offscreenContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    if (self.offscreenContext != NULL) {
//        CGContextRelease(self.offscreenContext);
//    }
//    
//    
//    
//}

- (void)dealloc {
    
    if (self.offscreenContext != NULL) {
        CGContextRelease(self.offscreenContext);
    }
}


- (void)drawRect:(CGRect)rect {
    NSAssert(self.offscreenContext != NULL, @"nil");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef offscreenImage = CGBitmapContextCreateImage(self.offscreenContext);
    CGContextDrawImage(context, self.bounds, offscreenImage);
    CGImageRelease(offscreenImage);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_stateFlag)return;
    NSAssert(self.offscreenContext != NULL, @"nil");
    self.lastLocation = [[touches anyObject] locationInView:self];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.lastLocation.x, self.lastLocation.y);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_stateFlag)return;
    
    UIColor *strokeColor = self.strokeColor ?: [UIColor blackColor];
    
    if (self.isErasing) {
        CGContextSaveGState(self.offscreenContext);
        CGContextSetBlendMode(self.offscreenContext, kCGBlendModeClear);
        CGContextSetAlpha(self.offscreenContext, 0.5);
        CGContextSetGrayFillColor(self.offscreenContext, 0.8, 0.6);
    }
    
    CGContextSetLineWidth(self.offscreenContext, self.lineWidth);
    CGContextSetLineCap(self.offscreenContext, kCGLineCapRound);
    
    CGContextSetStrokeColorWithColor(self.offscreenContext, strokeColor.CGColor);
    
    CGContextMoveToPoint(self.offscreenContext,
                         self.lastLocation.x,
                         self.lastLocation.y);
    
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    CGContextAddLineToPoint(self.offscreenContext, touchLocation.x, touchLocation.y);
    
    CGContextStrokePath(self.offscreenContext);
    
    if (self.isErasing) {
        CGContextRestoreGState(self.offscreenContext);
    }
    
    self.lastLocation = touchLocation;
    [self setNeedsDisplay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
