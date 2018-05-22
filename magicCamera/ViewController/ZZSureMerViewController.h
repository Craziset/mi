//
//  ZZSureMerViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZSureMerViewController : sywBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *choseImageView;
@property (strong, nonatomic) IBOutlet UIView *maiView;
@property(strong,nonatomic)NSDictionary *NextproductDic; //产品的信息
@property(nonatomic,strong)UIImage *selectImage;
@property (nonatomic, strong) UIImage *tShirtImage;


@end
