//
//  QuartView.h
//  magicCamera
//
//  Created by corepass on 2018/5/19.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuartView : UIView

@property(nonatomic, strong)NSArray* A1Arr; //第一组坐标
@property(nonatomic, strong)NSArray* A2Arr; //第二组坐标
@property(nonatomic, strong)UIImage* image;

@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;

@property(nonatomic, assign)float xishu;

@property(nonatomic,assign)CGFloat A1X;
@property(nonatomic,assign)CGFloat A1Y;

@property(nonatomic,assign)CGFloat A2X;
@property(nonatomic,assign)CGFloat A2Y;

@end
