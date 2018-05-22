//
//  SongColorView.h
//  AddShoppingCart
//
//  Created by jianpan on 2017/11/15.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SongColorTypeSeleteDelegete <NSObject>
-(void)SongColorbtnindex:(int) tag;
@end

@interface SongColorView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<SongColorTypeSeleteDelegete> delegate;
-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;

@end
