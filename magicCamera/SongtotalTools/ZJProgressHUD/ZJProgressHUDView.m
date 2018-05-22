//
//  ZJProgressHUDView.m
//  ZJProgressHUD
//
//  Created by ZeroJ on 16/9/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJProgressHUDView.h"
#import "ZJPrivateHUDProtocol.h"

@interface ZJProgressHUDView ()<ZJPrivateHUDProtocol> {
    CGSize _textSize;
}
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UILabel *label;
@end

static const CGFloat padding = 10.0f;
static const CGFloat indicatorHeight = 30.0f;

@implementation ZJProgressHUDView


- (instancetype)init {
    
    if (self = [super init]) {
        
        [self commonInit];
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)]) {
        
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    [self addSubview:self.indicatorView];
    
    self.backgroundColor = [[UIColor colorWithHexString:@"#666666"] colorWithAlphaComponent:0.45];
    //self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.];
    
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    _textSize = CGSizeZero;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    if (self.label.text) {
        CGRect indicatorFrame = CGRectZero;
        indicatorFrame.origin.x = (self.bounds.size.width - indicatorHeight)/2;
        indicatorFrame.origin.y = padding;
        indicatorFrame.size = CGSizeMake(indicatorHeight, indicatorHeight);
        self.indicatorView.frame = indicatorFrame;
        
        CGRect labelFrame = CGRectZero;
        labelFrame.origin.x = (self.bounds.size.width - _textSize.width)/2;
        labelFrame.origin.y = CGRectGetMaxY(self.indicatorView.frame) + padding;
        labelFrame.size = _textSize;
        self.label.frame = labelFrame;
        
    }
    else {
        
        self.indicatorView.frame = self.bounds;
    }
}

- (void)setText:(NSString *)text {
    
    if (text && ![text isEqualToString:@""]) {
        
        self.label.text = text;
        self.label.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.label];
        
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 100.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGRect frame = self.frame;
        
        frame.size.width = textRect.size.width + 2*padding;
        
        if (frame.size.width > screenWidth) {
            frame.size.width = screenWidth - 2*padding;
        }
        
        _textSize = textRect.size;
        frame.size.width = MAX(frame.size.width, indicatorHeight);
        frame.size.height = textRect.size.height + indicatorHeight + 3*padding;
        frame.size.width = MAX(frame.size.height, frame.size.width);
        self.frame = frame;
    }
    
    else {
        
        self.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    }
    
    [self layoutIfNeeded];

}

- (void)startAnimation {
    
    [self.indicatorView startAnimating];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    
    _indicatorColor = indicatorColor;
    
    self.indicatorView.color = indicatorColor;
    
}

- (UIActivityIndicatorView *)indicatorView {
    
    if (!_indicatorView) {
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.color = [UIColor whiteColor];
        _indicatorView = indicatorView;
        
    }
    
    return _indicatorView;
}

- (UILabel *)label {
    
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:17.0];
        _label = label;
    }
    
    return _label;
}


@end
