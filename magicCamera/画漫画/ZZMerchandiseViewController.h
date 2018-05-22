//
//  ZZMerchandiseViewController.h
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZSourceTagModel.h"
#import "ZZSourcePicModel.h"

@interface ZZMerchandiseViewController : sywBaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *merchandiseConView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic,strong)UIImage *selectImage;

@property (nonatomic, strong) ZZSourceTagModel *tagModel;
@property (nonatomic, strong) ZZSourcePicModel *picModel;
@property (nonatomic, strong) NSString *creative_id; //素材id
@property (nonatomic, copy) NSString *thumbnailStr;
@property (nonatomic, copy) NSString *imageUrl;


@end
