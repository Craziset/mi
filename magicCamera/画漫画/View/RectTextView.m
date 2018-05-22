//
//  RectTextView.m
//  MoveLabel
//
//  Created by 温春宇 on 16/7/26.
//  Copyright © 2016年 wcy. All rights reserved.
//

#import "RectTextView.h"

#define CSCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define CSCR_HEIGHT [UIScreen mainScreen].bounds.size.height
#define  CRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface RectTextView()<UITextViewDelegate>


@end
@implementation RectTextView

+ (instancetype)initTextViewWithText:(NSString *)text superView:(UIView *)superView point:(CGPoint)point tag:(NSInteger)tag{
    RectTextView *textView = [[RectTextView alloc]init];
    textView.tag = tag;
    CGFloat textH = [textView HeightWithTxt:text width:CSCR_WIDTH*0.6]+5;
    CGFloat textW = CSCR_WIDTH*0.6 > (text.length)*17 ?(text.length)*17:CSCR_WIDTH*0.6;
    textView.textH = textH;
    textView.textW = textW;
    CGFloat vH = textH+35;
    CGFloat vW = textW+35;
    textView.frame = CGRectMake(point.x - vW/2, point.x -vH/2, vW, vH);
    [textView creatUIWithText:text];
    [superView addSubview:textView];
    
    return textView;
}

- (void)creatUIWithText:(NSString *)text {
    
    self.cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.cleanBtn setImage:[UIImage imageNamed:@"删除"] forState:(UIControlStateNormal)];
    self.cleanBtn.backgroundColor = [UIColor grayColor];
    self.cleanBtn.hidden = YES;
    [self addSubview:self.cleanBtn];
    self.cleanBtn.layer.cornerRadius = 10;
    [self.cleanBtn addTarget:self action:@selector(clickCleanBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.tView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, self.textW, self.textH)];
    self.textField = [[UITextView alloc]initWithFrame:CGRectMake(1, 1, self.textW-2, self.textH-2)];
    self.textField.backgroundColor = [UIColor clearColor];
    self.tView.backgroundColor = [UIColor clearColor];
    self.textField.delegate = self;
    
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.showsVerticalScrollIndicator = NO;
    
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.textW, self.textH)];
//    self.textLabel.attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.textLabel.numberOfLines = 0;
    
    self.border= [CAShapeLayer layer];
    self.border.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.border.fillColor = nil;
    self.border.path = [UIBezierPath bezierPathWithRect:self.textLabel.bounds].CGPath;
    self.border.frame = self.textLabel.bounds;
    self.border.lineWidth = 1.f;
    self.border.lineCap = @"square";
    self.border.lineDashPattern = @[@4, @2];
    
    self.vBorder= [CAShapeLayer layer];
    self.vBorder.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.vBorder.fillColor = nil;
    self.vBorder.path = [UIBezierPath bezierPathWithRect:self.tView.bounds].CGPath;
    self.vBorder.frame = self.tView.bounds;
    self.vBorder.lineWidth = 1.f;
    self.vBorder.lineCap = @"square";
    self.vBorder.lineDashPattern = @[@4, @2];
    
    
    [self.textLabel.layer addSublayer:self.border];
    [self.tView.layer addSublayer:self.vBorder];
    
    [self.tView addSubview:self.textField];
    [self addSubview:self.tView];
    [self addSubview:self.textLabel];
    
    self.tapBtn.frame = self.tView.frame;
//    self.tapBtn.hidden = YES;
//    [self addSubview:self.tapBtn];
    
    __weak typeof(self) weakSelf = self;
    self.frameBlock = ^(CGSize size) {
        
        weakSelf.tView.frame = CGRectMake(20, 20, size.width-35, size.height-35);
        weakSelf.textField.frame = CGRectMake(1, 1, size.width-37, size.height-37);
        weakSelf.textLabel.frame = CGRectMake(20, 20, size.width-35, size.height-35);
        weakSelf.tapBtn.frame = weakSelf.textLabel.frame;
        weakSelf.border.path = [UIBezierPath bezierPathWithRect:weakSelf.textLabel.bounds].CGPath;
        weakSelf.border.frame = weakSelf.textLabel.bounds;
        
        weakSelf.vBorder.path = [UIBezierPath bezierPathWithRect:weakSelf.tView.bounds].CGPath;
        weakSelf.vBorder.frame = weakSelf.tView.bounds;
    

    };
}

- (void)showLine {
    self.border.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.vBorder.strokeColor = CRGBA(107, 188, 99, 1).CGColor;
    self.selectShow = YES;
    self.textLabel.hidden = YES;
    self.tView.hidden = NO;
    [self.textField becomeFirstResponder];
    [self.tView.layer addSublayer:self.vBorder];
    [self.textLabel.layer addSublayer:self.border];
    if (self.selectBlock) {
        self.selectBlock(self.tag, YES,self.textLabel);
    }
}



- (void)hideTetxView {
    self.textLabel.hidden = NO;
    self.tView.hidden = YES;
    if (self.selectBlock) {
        self.selectBlock(self.tag, YES,self.textLabel);
    }
}


- (void)hiddenLine {
    self.border.strokeColor = CRGBA(255, 255, 255, 0).CGColor;
    
    self.cleanBtn.hidden = YES;
    self.selectShow = NO;
    
    if (self.selectBlock) {
        self.selectBlock(self.tag, NO,self.textLabel);
    }
}


#warning 高度计算方法（一段文本按照固定宽度 所占得矩形区域）
- (CGFloat)HeightWithTxt:(NSString *)txt width:(CGFloat)w
{
    //参数1.预期尺寸范围
    CGSize size = CGSizeMake(w, 1200);
    //参数2.绘制选项
    //参数3.文本属性（字体， 字号）
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    //参数4。没用
    CGRect r = [txt boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return r.size.height;
}

- (void)clickCleanBtn:(UIButton *)btn {
    [self removeSetupUI];
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(deletePressViewTag:label:)]) {
        [self.delegate deletePressViewTag:self.tag label:self.textLabel];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat textH = textView.contentSize.height;
    CGFloat textW = textView.contentSize.width;
    
    CGFloat vH = textH+35;
    CGFloat vW = textW+35;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, vW, vH);
    self.tView.frame = CGRectMake(20, 20, textW, textH);
    
    
    
    self.textLabel.frame = self.tView.frame;
    self.textField.frame = self.tView.bounds;
    self.tapBtn.frame = self.tView.frame;
    
    self.border.path = [UIBezierPath bezierPathWithRect:self.textLabel.bounds].CGPath;
    self.border.frame = self.textLabel.bounds;
    self.vBorder.path = [UIBezierPath bezierPathWithRect:self.tView.bounds].CGPath;
    self.vBorder.frame = self.tView.bounds;
    [self.tView.layer addSublayer:self.vBorder];
    [self.textLabel.layer addSublayer:self.border];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

//    [self.tView.layer addSublayer:self.border];
    self.textLabel.text = textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self setupUI2];

    self.cleanBtn.hidden = NO;
    self.isShowLine = YES;
//    self.tapBtn.hidden = NO;
    [self hideTetxView];
    self.textLabel.text = textView.text;
    
    
}

- (UIButton *)tapBtn {
    if (!_tapBtn) {
        _tapBtn = [[UIButton alloc]init];
        _tapBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        [_tapBtn addTarget:self action:@selector(clickTapBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _tapBtn;
}

- (void)clickTapBtn:(UIButton *)btn {
    btn.hidden = YES;
    [self hiddenLine];
    [self removeSetupUI];
    
}





@end

