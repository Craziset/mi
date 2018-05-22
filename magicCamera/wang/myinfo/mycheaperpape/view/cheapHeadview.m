//
//  cheapHeadview.m
//  magicCamera
//
//  Created by Myself on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "cheapHeadview.h"

@implementation cheapHeadview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"cheapHeadview" owner:self options:nil]lastObject];
        self.backgroundColor=[UIColor whiteColor];
        self.frame = frame;
    }
    return self;
}


@end
