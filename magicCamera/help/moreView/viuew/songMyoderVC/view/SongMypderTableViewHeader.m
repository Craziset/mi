//
//  SongMypderTableViewHeader.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongMypderTableViewHeader.h"

@implementation SongMypderTableViewHeader
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _OderNumberLab  =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 25)];
        _OderNumberLab.textColor  = [UIColor colorWithHexString:@"#8c8c8c"];
        _OderNumberLab.font  =[UIFont systemFontOfSize:12];
        _OderNumberLab.text  = @"订单编号：12356987458962";
        
        
        _OderTimeLab  =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-160, 5, 150, 25)];
        _OderTimeLab.textColor  = [UIColor colorWithHexString:@"#8c8c8c"];
        _OderTimeLab.font  =[UIFont systemFontOfSize:12];
        _OderTimeLab.textAlignment = NSTextAlignmentRight;
        _OderTimeLab.text  = @"订单时间：2017-11-14";
        
        
         [self addSubview:_OderNumberLab];
         [self addSubview:_OderTimeLab];
    }
    return  self;
    
}

-(void)configureCellWithModel:(SongHeadmodel *)ExhbitMode{
    _OderNumberLab.text = [NSString stringWithFormat:@"订单编号：%@",ExhbitMode.Orderorder_idStr];
    NSTimeInterval time = [ExhbitMode.created_at doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* dateString = [formatter stringFromDate:date];
     _OderTimeLab.text = [NSString stringWithFormat:@"下单时间：%@",dateString];
}


@end
