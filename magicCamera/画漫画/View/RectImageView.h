//
//  RectImageView.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/25.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "XXRectView.h"

@interface RectImageView : XXRectView

//选中状态
@property (nonatomic,assign)BOOL selectShow;

/**
选中状态
*/
@property (nonatomic, copy) void(^selectBlock)(NSInteger tag,BOOL select,UIImageView *imageV);

@property (nonatomic, strong) UIButton *cleanBtn;
@property (nonatomic, strong) UIButton *rotatBtn;
@property (nonatomic, strong) CAShapeLayer *border;
@property (nonatomic, strong) UIImageView *imageView;

+ (instancetype)initImageViewWithUrl:(NSString *)url SuperView:(UIView *)superView point:(CGPoint)point tag:(NSInteger)tag;


@end
