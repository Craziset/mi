//
//  ZZDrawingViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/13.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZDrawingViewController : sywBaseViewController

@property (nonatomic, strong) UIImage *image;

@property(nonatomic,copy)NSString *image_nameSting;

//上  Laebl
@property (weak, nonatomic) IBOutlet UILabel *selectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *drawingLabel;
@property (weak, nonatomic) IBOutlet UILabel *chose_label;
@property (weak, nonatomic) IBOutlet UILabel *bug_someSting;
@property (weak, nonatomic) IBOutlet LXFDrawBoard *draw_image_view;

@property (weak, nonatomic) IBOutlet UIButton *sucai_button;
@property (weak, nonatomic) IBOutlet UIButton *huabi_button;
@property (weak, nonatomic) IBOutlet UIButton *wenzi_button;
@property (weak, nonatomic) IBOutlet UIButton *xiangpicha_button;

@property (weak, nonatomic) IBOutlet UIButton *next_button_clicked;
@property (weak, nonatomic) IBOutlet UISlider *panel_size;

@property (weak, nonatomic) IBOutlet UISlider *transparency;

@property(nonatomic,assign)NSInteger index;

















//color
@property (weak, nonatomic) IBOutlet UILabel *dangqianLabel;

@property (weak, nonatomic) IBOutlet UILabel *Lebel1;
@property (weak, nonatomic) IBOutlet UILabel *Lebel2;
@property (weak, nonatomic) IBOutlet UILabel *Lebel3;
@property (weak, nonatomic) IBOutlet UILabel *Lebel4;
@property (weak, nonatomic) IBOutlet UILabel *Lebel5;
@property (weak, nonatomic) IBOutlet UILabel *Lebel6;
@property (weak, nonatomic) IBOutlet UILabel *Lebel7;
@property (weak, nonatomic) IBOutlet UILabel *Lebel8;
@property (weak, nonatomic) IBOutlet UILabel *Lebel9;


@property (weak, nonatomic) IBOutlet UIImageView *colorImageView;









@end
