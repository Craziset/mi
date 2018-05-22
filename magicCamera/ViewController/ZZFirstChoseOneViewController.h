//
//  ZZFirstChoseOneViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/9/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZZFirstChoseOneViewController : sywBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *back_button_all;

@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIView *title_view;

@property (weak, nonatomic) IBOutlet UIButton *nextButton_clicked;
// threeViewButton
@property (weak, nonatomic) IBOutlet UIButton *big_small_Button;
@property (weak, nonatomic) IBOutlet UIButton *color_button;
//twoViewbutton
@property (weak, nonatomic) IBOutlet UIButton *twoView_setButton;
@property (weak, nonatomic) IBOutlet UIButton *twoView_colorButton;
@property (strong, nonatomic) IBOutlet UIView *eraser_View;


@end
