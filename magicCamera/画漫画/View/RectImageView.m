//
//  RectImageView.m
//  magicCamera
//
//  Created by 徐征 on 2018/1/25.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "RectImageView.h"

#define CSCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define CSCR_HEIGHT [UIScreen mainScreen].bounds.size.height
#define  CRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface RectImageView()


@end

@implementation RectImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (instancetype)initImageViewWithUrl:(NSString *)url SuperView:(UIView *)superView point:(CGPoint)point tag:(NSInteger)tag {
    
    RectImageView *rView = [[RectImageView alloc]init];
    rView.tag = tag;
    CGFloat imageW = 180*rateh;
    CGFloat rW = imageW + 35;
    rView.frame = CGRectMake(point.x - rW/2, point.y - rW/2, rW, rW);
    [rView creatUIWithImageUrl:url];
    [superView addSubview:rView];
    [rView hiddenLine];
    rView.isShowLine = YES;
    return rView;
}

- (void)creatUIWithImageUrl:(NSString *)url {
    self.cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.cleanBtn setImage:[UIImage imageNamed:@"删除"] forState:(UIControlStateNormal)];
    self.cleanBtn.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.cleanBtn];
    self.cleanBtn.layer.cornerRadius = 10;
    [self.cleanBtn addTarget:self action:@selector(clickCleanBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rotatBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-10, 0, 20, 20)];
    [self.rotatBtn setImage:[UIImage imageNamed:@"spined"] forState:(UIControlStateNormal)];
    [self.rotatBtn setImage:[UIImage imageNamed:@"spin"] forState:(UIControlStateSelected)];
    
    
    self.rotatBtn.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.rotatBtn];
    self.rotatBtn.layer.cornerRadius = 10;
    [self.rotatBtn addTarget:self action:@selector(clickRotatBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imageW = 180*rateh;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, imageW, imageW)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"common_nopic"]];
    
    self.border= [CAShapeLayer layer];
    self.border.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.border.fillColor = nil;
    self.border.path = [UIBezierPath bezierPathWithRect:self.imageView.bounds].CGPath;
    self.border.frame = self.imageView.bounds;
    self.border.lineWidth = 1.f;
    self.border.lineCap = @"square";
    self.border.lineDashPattern = @[@4, @2];
    [self.imageView.layer addSublayer:self.border];
    
    [self addSubview:self.imageView];
    __weak typeof(self) weakSelf = self;
    self.frameBlock = ^(CGSize size) {
        
        //        CGFloat h = size.height > size.width ? size.width:size.height;
        CGFloat w = size.width;
        CGFloat h = size.height;
        //        if (h<=100) {
        //            h = 100;
        //        }else if (h >= 250){
        //            h = 250;
        //        }
        
        weakSelf.imageView.frame = CGRectMake(20, 20,w-35, h-35);
        weakSelf.border.path = [UIBezierPath bezierPathWithRect:weakSelf.imageView.bounds].CGPath;
        weakSelf.border.frame = weakSelf.imageView.bounds;
        weakSelf.rotatBtn.frame = CGRectMake(w -10, 0, 20, 20);
    };
    
}

- (void)showLine {
    self.border.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.cleanBtn.hidden = NO;
    self.rotatBtn.hidden = NO;
    self.selectShow = YES;
    [self setupUI2];
    [self.imageView.layer addSublayer:self.border];
    
    if (self.selectBlock) {
        self.selectBlock(self.tag, YES,self.imageView);
    }
}

- (void)hiddenLine {
    self.border.strokeColor = CRGBA(255, 255, 255, 0).CGColor;
    self.cleanBtn.hidden = YES;
    self.selectShow = NO;
    self.rotatBtn.hidden = YES;
    if (self.selectBlock) {
        self.selectBlock(self.tag, NO,self.imageView);
    }
}

- (void)clickCleanBtn:(UIButton *)btn {
    [self removeSetupUI];
    
    [self removeFromSuperview];
}


- (void)clickRotatBtn:(UIButton *)btn {
    
    btn.selected = !btn.selected ;
    if (btn.selected) {
        //动画开始
        [UIView beginAnimations:@"rotate" context:nil ];
        //动画时长
        [UIView setAnimationDuration:0.1];
        //获取transform的值
        [self.imageView setTransform:CGAffineTransformMakeScale(-1.0,1.0)];
        //关闭动画
        [UIView commitAnimations];
    }else {
        [self clockwiseRotation];
    }
}

- (void)clockwiseRotation{
    
    [UIView beginAnimations:@"counterclockwiseAnimation"context:NULL];
    /* 5 seconds long */
    [UIView setAnimationDuration:0.1f];
    /* 回到原始旋转 */
    self.imageView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}



@end

