//
//  DrawBoardView.m
//  miliu
//
//  Created by hibo on 2017/11/16.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "DrawBoardView.h"
#import "BaseController.h"


@implementation DrawBoardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        pathModalArray = [NSMutableArray array];
        self.lineColor = [UIColor blackColor];//默认画笔颜色
        self.lineWidth = 5.0;//默认线宽
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.currentLine.color = _lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.currentLine.width = _lineWidth;
}



-(void)layoutSubviews{
    [super layoutSubviews];
//    if (self.offscreenContext != NULL) {
//        CGContextRelease(self.offscreenContext);
//    }
    if (!self.isErasing) {

    CGSize viewSize = self.frame.size;
    size_t width = viewSize.width;
    size_t height = viewSize.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    self.offscreenContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    }
}

- (void)dealloc {
    if (self.offscreenContext != NULL) {
        CGContextRelease(self.offscreenContext);
    }
}


- (void)drawRect:(CGRect)rect {
    NSAssert(self.offscreenContext != NULL, @"nil");
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (Line *line in pathModalArray) {
        [line.color setStroke];
        CGContextSetLineWidth(context,line.width);
        CGContextAddPath(context, line.path);
        CGContextDrawPath(context, kCGPathStroke);
//        CGImageRef offscreenImage = CGBitmapContextCreateImage(self.offscreenContext);
//        CGContextDrawImage(context, self.bounds, offscreenImage);
//        CGImageRelease(offscreenImage);
    }
    if (path) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        [self.lineColor setStroke];
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextDrawPath(context, kCGPathStroke);
        
    }
    
    CGImageRef offscreenImage = CGBitmapContextCreateImage(self.offscreenContext);
    CGContextDrawImage(context, self.bounds, offscreenImage);
    CGImageRelease(offscreenImage);
//    if (self.erasing) {
//        NSAssert(self.offscreenContext != NULL, @"nil");
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGImageRef offscreenImage = CGBitmapContextCreateImage(self.offscreenContext);
//        CGContextDrawImage(context, self.bounds, offscreenImage);
//        CGImageRelease(offscreenImage);
//
//
//    }
}
- (void)undo {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}
- (void)redo {
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_stateFlag)return;
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    self.lastLocation = p;
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    NSLog(@"开始");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_stateFlag)return;

    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    UIColor *strokeColor = [UIColor redColor];
    if (self.isErasing) {

        CGContextSaveGState(self.offscreenContext);
        CGContextSetBlendMode(self.offscreenContext, kCGBlendModeClear);
        CGContextSetAlpha(self.offscreenContext, 0.5);
        CGContextSetGrayFillColor(self.offscreenContext, 0.8, 0.6);
    }
    CGContextSetLineWidth(self.offscreenContext, self.lineWidth);
    CGContextSetLineCap(self.offscreenContext, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(self.offscreenContext, self.lineColor.CGColor);
//    for (int i = 0; i<pathModalArray.count; i++) {
//        Line *line = pathModalArray[i];
//
//
//
//    }
//    CGContextSetStrokeColorWithColor(self.offscreenContext, strokeColor.CGColor);
    CGContextAddLineToPoint(self.offscreenContext, p.x, p.y);

    CGContextMoveToPoint(self.offscreenContext,
                         self.lastLocation.x,
                         self.lastLocation.y);
    CGContextStrokePath(self.offscreenContext);
    if (self.isErasing) {
        CGContextRestoreGState(self.offscreenContext);
        [pathModalArray removeAllObjects];

    }else{
        CGPathAddLineToPoint(path, NULL, p.x, p.y);

    }
    self.lastLocation = p;

    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (!_stateFlag)return;
    Line *line = [[Line alloc] init];
    line.color = self.lineColor;
    line.width = self.lineWidth;
    line.path = path;
    [pathModalArray addObject:line];
    CGPathRelease(path);
    path = nil;
    NSLog(@"结束");
}
-(void)undoAction{
    
    [pathModalArray removeLastObject];
    self.erasing = YES;
    [self setNeedsDisplay];
}
-(void)clearAction{
    [pathModalArray removeAllObjects];
    [self setNeedsDisplay];
}

@end


//存储属性
@implementation Line
- (id)init {
    self = [super init];
    if (self) {
//        [self setColor:[UIColor blackColor]];
        [self setWidth:5.0];
    }
    return self;
}
-(void)setPath:(CGMutablePathRef)path{
    if (_path!=path) {
        _path = (CGMutablePathRef)CGPathRetain(path);
    }
}
@end
