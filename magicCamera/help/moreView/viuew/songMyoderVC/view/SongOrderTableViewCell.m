//
//  SongOrderTableViewCell.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "SongOrderTableViewCell.h"
@implementation SongOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _atvorImg  = [[UIImageView alloc]initWithFrame:CGRectMake(8, 5*HEIGHT/XMultiple, 55, 60)];
        _NameLab  =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_atvorImg.frame)+5, 5, 150*WIDTH/320, 25)];
        _NameLab.textColor  = [UIColor colorWithHexString:@"#333333"];
        _NameLab.font  =[UIFont systemFontOfSize:14];
        _NameLab.text  = @"蔬菜蔬菜专fvfvbgbgbbhnjn家";
        
        _PriceLab  =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-80,7*HEIGHT/XMultiple, 70, 20)];
        _PriceLab.textColor  = [UIColor colorWithHexString:@"#333333"];
        _PriceLab.font  =[UIFont systemFontOfSize:12];
        _PriceLab.textAlignment = NSTextAlignmentRight;
        _PriceLab.text  = @"￥ 1530";
        
        _ColorLab  =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_atvorImg.frame)+5,CGRectGetMaxY(_NameLab.frame)+5, 150, 20)];
        _ColorLab.textColor  = [UIColor colorWithHexString:@"#8c8c8c"];
        _ColorLab.font  =[UIFont systemFontOfSize:12];
        _ColorLab.textAlignment = NSTextAlignmentLeft;
        _ColorLab.text  = @"规格：蓝色";
        
        _NumberLab  =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100,CGRectGetMaxY(_NameLab.frame)+5, 90, 20)];
        _NumberLab.textAlignment = NSTextAlignmentRight;
        _NumberLab.textColor  = [UIColor colorWithHexString:@"#333333"];
        _NumberLab.font  =[UIFont systemFontOfSize:12];
        _NumberLab.text  = @"X10";
        
       
//
        [self addSubview:_atvorImg];
        [self addSubview:_NameLab];
        [self addSubview:_PriceLab];
        [self addSubview:_ColorLab];
        [self addSubview:_NumberLab];
        
        
    }
    return self;
    
}


- (void)setModel:(SongOrderTablemodel *)model
{
    [_atvorImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail[0]]] placeholderImage:[UIImage imageNamed:@"common_nopic"]];
    
    _NameLab.text = model.product_temp_name;
    _PriceLab.text = [NSString stringWithFormat:@"%.2f",[model.preferential_price floatValue]];
    _ColorLab.text = [NSString stringWithFormat:@"规格: %@",model.ProductColour_nameStr];;
    _NumberLab.text = [NSString stringWithFormat:@" X%@",model.ProductNumberStr];
}

-(void)configureCellWithModel:(SongOrderTablemodel *)Electimage{
    
    [_atvorImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Electimage.ImagesStr]] placeholderImage:[UIImage imageNamed:@"common_nopic"]];
  
    _NameLab.text = Electimage.ProductNameStr;
    _PriceLab.text = [NSString stringWithFormat:@"%.2f",[Electimage.ProductPriceStr floatValue]];
    _ColorLab.text = [NSString stringWithFormat:@"规格: %@",Electimage.ProductColour_nameStr];;
    _NumberLab.text = [NSString stringWithFormat:@" X%@",Electimage.ProductNumberStr];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
