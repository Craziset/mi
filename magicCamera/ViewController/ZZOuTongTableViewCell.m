//
//  ZZOuTongTableViewCell.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZOuTongTableViewCell.h"

@implementation ZZOuTongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.RamkarText.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
