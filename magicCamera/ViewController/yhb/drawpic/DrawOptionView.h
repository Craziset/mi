//
//  DrawOptionView.h
//  miliu
//
//  Created by hibo on 2017/11/15.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import <UIKit/UIKit.h>

//自定义tableview
typedef void(^resultBlock)(id result);
@interface DrawOptionView : UIView

#pragma mark - 素材
-(void)setMaterialWithResult:(resultBlock)block;
#pragma mark - 笔画
-(void)setPenWithResult:(resultBlock)block;
#pragma mark - 字体
-(void)setWordWithResult:(resultBlock)block;
//橡皮擦
- (void)setEraserResult:(resultBlock)block;

@end
