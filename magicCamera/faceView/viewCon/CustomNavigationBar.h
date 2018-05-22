//
//  CustomNavigationBar.h
//  magicCamera
//
//  Created by 徐征 on 2017/11/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UINavigationBar
@property (nonatomic, assign)CGFloat spaceBetweenItems;
@property (nonatomic,assign) CGFloat leftValue;

- (void)setItemsSpace:(CGFloat)space;

@end
