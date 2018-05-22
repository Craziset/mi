//
//  DrawPicController.h
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "BaseController.h"
#import "ZZSourceTagModel.h"
#import "ZZSourcePicModel.h"

@interface DrawPicController : BaseController
@property (nonatomic,strong) UIImage *selectImage;//选择的图片

@property (nonatomic, strong) ZZSourceTagModel *tagModel;
@property (nonatomic, strong) ZZSourcePicModel *picModel;


@end
