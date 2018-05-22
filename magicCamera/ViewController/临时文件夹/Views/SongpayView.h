//
//  SongpayView.h
//  magicCamera
//
//  Created by 宋建 on 2017/11/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayDeletagte<NSObject>
-(void)PayBtn:(NSString *)tag;
@end
@interface SongpayView : UIView<UITableViewDelegate,UITableViewDataSource>

-(instancetype)initWithFrame:(CGRect)frame withStr:(NSString *)str;
@property(nonatomic,strong)UITableView *payTab;

@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSArray *arrlmag;
@property(nonatomic,strong)NSString *Price;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,assign)id<PayDeletagte>deleagte;
@property(nonatomic,strong)NSString *tagStr;
-(void)pop;
-(void)dissMis;

@end
