//
//  ThirdBtnView.h
//  QiChengApp
//
//  Created by 飞兔 on 16/8/6.
//  Copyright © 2016年 杨元. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ThirdBtnViewDelegate <NSObject>
-(void)didtapBtn:(UIButton *)btn;
@end
@interface ThirdBtnView : UIView
{
     NSInteger  _currentIndex;
    NSMutableArray *btnArray;
}
//代理
@property(nonatomic,unsafe_unretained)id<ThirdBtnViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * normalBotImage;
@property(nonatomic,strong)UIImageView * secBotImage;
@property(nonatomic,strong)UIButton * currentBtn;
@property(nonatomic,strong)UIScrollView *bgSrollview;
-(id)initWithFrame:(CGRect)frame WithBtnNameArr:(NSArray *)arr WithNsinteg:(NSUInteger)tag;
@end
