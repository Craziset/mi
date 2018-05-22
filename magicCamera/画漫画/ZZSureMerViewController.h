//
//  ZZSureMerViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZSourceTagModel.h"
#import "ZZSourcePicModel.h"

@class ProductModel;
@interface ZZSureMerViewController : sywBaseViewController

@property (nonatomic, strong) ZZSourceTagModel *tagModel;
@property (nonatomic, strong) ZZSourcePicModel *picModel;
@property (nonatomic, strong) NSString *creative_id; //涂鸦素材id

@property (nonatomic, copy)NSString* thumbnail1;
@property (weak, nonatomic) IBOutlet UIImageView *choseImageView;
@property (strong, nonatomic) IBOutlet UIView *maiView;
//@property (nonatomic, strong) ProductModel *productModel;

@property(nonatomic,strong)UIImage *selectImage;
//@property (nonatomic, strong) UIImage *tShirtImage;
@property (nonatomic, strong) NSString *tshirtUrl;
@property (nonatomic, copy) NSString *temp_id;
@property (nonatomic, copy) NSString* design_model;

@end

