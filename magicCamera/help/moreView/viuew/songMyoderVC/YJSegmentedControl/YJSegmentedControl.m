//
//  YJSegmentedControl.m
//  YJButtonLine
//
//  Created by houdage on 15/11/13.
//  Copyright © 2015年 houdage. All rights reserved.
//

#import "YJSegmentedControl.h"

@interface YJSegmentedControl ()<YJSegmentedControlDelegate>{
    CGFloat witdthFloat;
    UIView * buttonDownView;
    NSInteger selectSeugment;
    NSMutableArray *arrBtn;
}
@end

@implementation YJSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.btnTitleSource = [NSMutableArray array];
        selectSeugment = 0;
        arrBtn = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}


+ (YJSegmentedControl *)segmentedControlFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSouece backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor buttonDownColor:(UIColor *)buttonDownColor Delegate:(id)delegate StuatsTag:(NSInteger)StuatsTag{
    

    YJSegmentedControl * smc = [[self alloc] initWithFrame:frame];
    smc.backgroundColor = backgroundColor;
    smc.buttonDownColor = buttonDownColor;
   
    smc.titleColor = titleColor;
    smc.titleFont = titleFont;
//    smc.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    smc.selectColor = selectColor;
    smc.delegate = delegate;
    [smc AddSegumentArray:titleDataSouece AndStuatsTag:StuatsTag];
    return smc;
}

- (void)AddSegumentArray:(NSArray *)SegumentArray AndStuatsTag:(NSInteger)StuatsTag{
    
    // 1.按钮的个数
    NSInteger seugemtNumber = SegumentArray.count;
    
    // 2.按钮的宽度
    witdthFloat = SCREEN_WIDTH / seugemtNumber;
    
    // 3.创建按钮
    for (int i = 0; i < SegumentArray.count; i++) {
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * witdthFloat, 0, witdthFloat, self.bounds.size.height - 2)];
        [btn setTitle:SegumentArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.titleFont];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        if (i==StuatsTag) {
            [btn setTitleColor:self.selectColor forState:UIControlStateNormal];
        }
        [arrBtn addObject:btn];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(changeSegumentAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            buttonDownView =[[UIView alloc]initWithFrame:CGRectMake(StuatsTag*witdthFloat, self.bounds.size.height - 2, witdthFloat, 1)];
            [buttonDownView setBackgroundColor:self.buttonDownColor];
            
            [self addSubview:buttonDownView];
        }
        [self addSubview:btn];
        [self.btnTitleSource addObject:btn];
    }
    
    [[self.btnTitleSource firstObject] setSelected:YES];
}

- (void)changeSegumentAction:(UIButton *)btn{
    
    for (UIButton *btn in arrBtn) {
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
    }
    
    btn = arrBtn[btn.tag-1];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];

    [self selectTheSegument:btn.tag - 1];
}

-(void)selectTheSegument:(NSInteger)segument{
    
    if (selectSeugment != segument) {
        
        [self.btnTitleSource[selectSeugment] setSelected:NO];
        [self.btnTitleSource[segument] setSelected:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [buttonDownView setFrame:CGRectMake(segument * witdthFloat,self.bounds.size.height - 2, witdthFloat, 1)];
        }];
        
        selectSeugment = segument;
        [self.delegate segumentSelectionChange:selectSeugment];
    }
}

@end
