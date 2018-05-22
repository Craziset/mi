//
//  XXChangeImageViewController.h
//  magicCamera
//
//  Created by 徐征 on 2017/12/2.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "sywBaseViewController.h"
#import "CustomTableView.h"

typedef void(^changeBlock)(UIImage *image);

@interface XXChangeImageViewController : sywBaseViewController

@property (nonatomic, copy) changeBlock imageBlock;

@end
