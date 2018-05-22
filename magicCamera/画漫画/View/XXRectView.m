//
//  XXRectView.m
//  magicCamera
//
//  Created by 徐征 on 2018/3/7.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "XXRectView.h"

@interface XXRectView(){
    
    //记录左上角箭头移动的起始位置
    CGPoint startPoint1;
    //记录右上角箭头移动的起始位置
    CGPoint startPoint2;
    //记录左下角箭头移动的起始位置
    CGPoint startPoint3;
    //记录右下角箭头移动的起始位置
    CGPoint startPoint4;
    //记录透明区域移动的起始位置
    CGPoint startPointMoveView;
}

@property (nonatomic, strong) UIView *rectangleView;

/** 左上角 左右滑动手势 */
@property (nonatomic, strong) UIImageView *arrow1;
/** 右上角 点击关闭 */
@property (nonatomic, strong) UIImageView *arrow2;
/** 左下角 上下滑动手势 */
@property (nonatomic, strong) UIImageView *arrow3;
/** 右下角 斜角移动手势 */
@property (nonatomic, strong) UIImageView *arrow4;

@end

@implementation XXRectView

//箭头的宽度
#define ARROWWIDTH 10
//箭头的高度
#define ARROWHEIGHT 10
//两个相邻箭头之间的最短距离
#define ARROWMINIMUMSPACE 10
//箭头单边的宽度
#define ARROWBORDERWIDTH 10
//imageview的左右缩进
#define PADDING 10
//裁剪区域的边框宽度
#define CROPVIEWBORDERWIDTH 2.0f

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveRectangleView:)];
        [self addGestureRecognizer:panGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveRectangleClick:)];
        
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

//- (void)showLine {
////    [self setNeedsDisplay];//调用重绘方法时候刷新
//
//    //metnhod one --可添加虚线
//    self.borderType = BorderTypeSolid;
//    self.borderWidth = 2;
//    self.borderColor = [UIColor redColor];
//
//}
//- (void)hiddenLine {
//
//    self.borderType = BorderTypeSolid;
//    self.borderWidth = 0;
//    self.borderColor = [UIColor clearColor];
//}

- (void)setupUI2 {
    [self removeSetupUI];
    [self.superview addSubview:self.arrow1];
    [self.superview addSubview:self.arrow2];
    [self.superview addSubview:self.arrow3];
    [self.superview addSubview:self.arrow4];
    
    CGRect rect = self.frame;
    
    CGFloat x1 = rect.origin.x;
    CGFloat y1 = rect.origin.y;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    self.rectangleView.frame = (self.frame);
    self.arrow1.frame = CGRectMake(x1, y1, 1, 1);
    self.arrow2.frame = CGRectMake(x1+w, y1, 1, 1);
    self.arrow3.frame = CGRectMake(x1, y1+h, 1, 1);
    self.arrow4.frame = CGRectMake(x1+w-15, y1+h-15, 20, 20);
    
}
- (void)removeSetupUI {
    [self.arrow1 removeFromSuperview];
    [self.arrow2 removeFromSuperview];
    [self.arrow3 removeFromSuperview];
    [self.arrow4 removeFromSuperview];
}
- (void)moveRectangleClick:(UITapGestureRecognizer *)tapGesture {
    
    //0.黑色小三角工具栏
    //1.添加边框线
    //2.添加四个角
    
    //添加对应四个按钮和显示蓝色边框
    
    if (self.isShowLine) {
        [self cancelLineAndCorner];
    }else{
        [self registerLineAndCorner];
    }
    
}
- (void)registerLineAndCorner{
    self.isShowLine = YES;
    [self showLine];
    //    [self setupUI2];
}
- (void)cancelLineAndCorner {
    self.isShowLine = NO;
    [self hiddenLine];
    [self removeSetupUI];
    
}
- (void)moveRectangleView:(UIPanGestureRecognizer *)panGesture {
    
    CGFloat minX = CGRectGetMinX(self.superview.frame);
    CGFloat maxX = CGRectGetMaxX(self.superview.frame) - CGRectGetWidth(self.frame);
    CGFloat minY = CGRectGetMinY(self.superview.frame);
    CGFloat maxY = CGRectGetMaxY(self.superview.frame) - CGRectGetHeight(self.frame);
    
    if(panGesture.state == UIGestureRecognizerStateBegan) {
        startPointMoveView = [panGesture locationInView:[self.rectangleView superview]];
    }
    else if(panGesture.state == UIGestureRecognizerStateEnded) {
        self.arrow1.userInteractionEnabled = YES;
        self.arrow2.userInteractionEnabled = YES;
        self.arrow3.userInteractionEnabled = YES;
        self.arrow4.userInteractionEnabled = YES;
    }
    else if(panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint endPoint = [panGesture locationInView:[self.rectangleView superview]];
        CGRect frame = panGesture.view.frame;
        frame.origin.x += endPoint.x - startPointMoveView.x;
        frame.origin.y += endPoint.y - startPointMoveView.y;
        frame.origin.x = MIN(maxX, MAX(frame.origin.x, minX));
        frame.origin.y = MIN(maxY, MAX(frame.origin.y, minY));
        panGesture.view.frame = frame;
        startPointMoveView = endPoint;
    }
    
    [self resetAllArrows];
}
/**
 *移动四个箭头的手势处理
 */
- (void)moveCorner:(UIPanGestureRecognizer *)panGesture {
    
    //设置起始值
    CGPoint *startPoint = NULL;
    //获取当前点击view的范围
    CGFloat minX = CGRectGetMinX(self.superview.frame);
    CGFloat maxX = CGRectGetMaxX(self.superview.frame);
    CGFloat minY = CGRectGetMinY(self.superview.frame);
    CGFloat maxY = CGRectGetMaxY(self.superview.frame);
    
    //判断对应图像角标(计算原理根据当前点的最大XY轴方向)
    if(panGesture.view == self.arrow4) {
        startPoint = &startPoint4;
        minY = CGRectGetMaxY(self.arrow2.frame);
        minX = CGRectGetMaxX(self.arrow3.frame);
    }
    //手势状态->开始点击
    if(panGesture.state == UIGestureRecognizerStateBegan) {
        *startPoint = [panGesture locationInView:self.superview];
        self.superview.userInteractionEnabled = NO;
    }//手势状态->点击停止
    else if(panGesture.state == UIGestureRecognizerStateEnded) {
        self.superview.userInteractionEnabled = YES;
    }//手势状态->值变化
    else if(panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint endPoint = [panGesture locationInView:self.superview];
        CGRect frame = panGesture.view.frame;
        frame.origin.x += endPoint.x - startPoint->x;
        frame.origin.y += endPoint.y - startPoint->y;
        frame.origin.x = MIN(maxX, MAX(frame.origin.x, minX));
        frame.origin.y = MIN(maxY, MAX(frame.origin.y, minY));
        if (frame.origin.x - self.frame.origin.x > 220 || frame.origin.y - self.frame.origin.y> 220 ) {
            frame.origin.x = self.frame.origin.x + 220;
            frame.origin.y = self.frame.origin.y + 220;
        }else if ( frame.origin.x - self.frame.origin.x< 100 || frame.origin.y - self.frame.origin.y< 100) {
            frame.origin.x = self.frame.origin.x + 100;
            frame.origin.y = self.frame.origin.y + 100;
        }
        if (frame.origin.x - self.frame.origin.x > frame.origin.y - self.frame.origin.y) {
            frame.origin.y = self.frame.origin.y + (frame.origin.x - self.frame.origin.x);
        }else {
            frame.origin.x = self.frame.origin.x +(frame.origin.y - self.frame.origin.y);
        }
        panGesture.view.frame = frame;
        *startPoint = endPoint;
    }
    //传递点击的手势所在view
    [self resetArrowsFollow: panGesture.view];
    [self resetCropView];
    //    [self resetSuperViewFrame];
    
}

- (void)resetCropView {
    CGFloat w = CGRectGetMaxX(self.arrow2.frame) - CGRectGetMinX(self.arrow1.frame);
    if (CGRectGetMaxX(self.arrow2.frame) - CGRectGetMinX(self.arrow1.frame) < CGRectGetMaxY(self.arrow3.frame) - CGRectGetMinY(self.arrow1.frame)) {
        w = CGRectGetMaxY(self.arrow3.frame) - CGRectGetMinY(self.arrow1.frame);
    }
    
    self.frame = CGRectMake(CGRectGetMinX(self.arrow1.frame), CGRectGetMinY(self.arrow1.frame), w, w);
    self.frameBlock(self.bounds.size);
}
/**
 *根据当前移动的箭头的位置重新设置与之一起变化位置的箭头的位置
 */
- (void)resetArrowsFollow: (UIView *)arrow {
    //根据当前点,对角线的点把持不变,改变都是相邻点的frame center
    
    if(arrow == self.arrow1) {
        self.arrow2.center = CGPointMake(self.arrow2.center.x, self.arrow1.center.y);
        self.arrow3.center = CGPointMake(self.arrow1.center.x, self.arrow3.center.y);
        
    }
    else if(arrow == self.arrow2) {
        
        self.arrow1.center = CGPointMake(self.arrow1.center.x, self.arrow2.center.y);
        self.arrow4.center = CGPointMake(self.arrow2.center.x, self.arrow4.center.y);
        
    }
    else if(arrow == self.arrow3) {
        
        self.arrow1.center = CGPointMake(self.arrow3.center.x, self.arrow1.center.y);
        self.arrow4.center = CGPointMake(self.arrow4.center.x, self.arrow3.center.y);
        
    }
    else if(arrow == self.arrow4) {
        
        self.arrow2.center = CGPointMake(self.arrow4.center.x, self.arrow2.center.y);
        self.arrow3.center = CGPointMake(self.arrow3.center.x, self.arrow4.center.y);
        
    }
    
}
/**
 *根据当前裁剪区域的位置重新设置所有角的位置
 */
- (void)resetAllArrows {
    self.arrow1.center = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
    self.arrow2.center = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame));
    self.arrow3.center = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame));
    self.arrow4.center = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
    [self layoutIfNeeded];
}


- (UIImageView *)arrow1 {
    if (!_arrow1) {
        _arrow1 = [[UIImageView alloc]init];
    }
    return _arrow1;
}
- (UIImageView *)arrow2 {
    if (!_arrow2) {
        _arrow2 = [[UIImageView alloc]init];
    }
    return _arrow2;
}
- (UIImageView *)arrow3 {
    if (!_arrow3) {
        _arrow3 = [[UIImageView alloc]init];
    }
    return _arrow3;
}
- (UIImageView *)arrow4 {
    if (!_arrow4) {
        _arrow4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"elementBorder3.png"]];
        _arrow4.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveCorner:)];
        _arrow4.tag = 88;
        [_arrow4 addGestureRecognizer:tapGesture];
    }
    return _arrow4;
}

@end
