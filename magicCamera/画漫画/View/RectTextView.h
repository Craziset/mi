//
//  RectTextView.h
//  MoveLabel
//
//  Created by 温春宇 on 16/7/26.
//  Copyright © 2016年 wcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMoveView.h"

@protocol rectTextViewDelegate<NSObject>;

- (void)deletePressViewTag:(NSInteger)tag label:(UILabel *)label;

@end

@interface RectTextView : BaseMoveView<UITextFieldDelegate>
@property (nonatomic, weak) id<rectTextViewDelegate> delegate;

/**
 选中状态
 */
@property (nonatomic, copy) void(^selectBlock)(NSInteger tag,BOOL select,UILabel *textLabel);


//选中状态
@property (nonatomic,assign)BOOL selectShow;



@property (nonatomic, strong) UITextView *textField;
@property (nonatomic, strong) UIView *tView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *tapBtn;

@property (nonatomic, strong) UIButton *cleanBtn;
@property (nonatomic, assign) CGFloat textW;
@property (nonatomic, assign) CGFloat textH;


@property (nonatomic, strong) CAShapeLayer *border;
@property (nonatomic,strong) CAShapeLayer *vBorder;


+ (instancetype)initTextViewWithText:(NSString *)text superView:(UIView *)superView point:(CGPoint)point tag:(NSInteger)tag;

@end

