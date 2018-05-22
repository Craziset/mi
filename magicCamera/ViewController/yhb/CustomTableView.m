//
//  CustomTableView.m
//  miliu
//
//  Created by hibo on 2017/11/15.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "CustomTableView.h"
#import "MyBaseView.h"
#import "UIImageView+WebCache.h"

/****************************适配*********************************/
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define ratew (Width/375.0)
#define rateh (Height/667.0)
#define CGRect(x,y,width,heigth)  CGRectMake((x)*ratew, (y)*rateh, width*ratew, heigth*rateh)
#define NAVHEIGHT (Height<812.0?64.0:88.0)
/****************************适配*********************************/
/****************************颜色*********************************/
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define RGB(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//自定义cell
@implementation BaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [MyBaseView myLabelFrame:CGRectMake((self.frame.size.height-self.frame.size.width)/2, self.frame.size.height, self.frame.size.width, self.frame.size.height) text:@"" textColor:RGB(58, 58, 58) backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _titleLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
    CGRect tmpFrame =  self.textLabel.frame ;
    self.titleLabel.frame = tmpFrame;
}
- ( void )layoutSubviews {
    [ super layoutSubviews ];
    self.imageView.bounds = CGRectMake (0,0,self.frame.size.height,self.frame.size.height);
    self.imageView.frame = CGRectMake (0,0,self.frame.size.height,self.frame.size.height);
    self.imageView.contentMode =  UIViewContentModeScaleAspectFit ;
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.imageView.layer.masksToBounds = YES;
    
    CGRect  tmpFrame =  self.textLabel.frame ;
    tmpFrame.origin.x  = 0;
    tmpFrame.origin.y = 0;
    tmpFrame.size.width = self.frame.size.width;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.frame = tmpFrame;
    self.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.titleLabel.frame = tmpFrame;
}

@end


//自定义tableview
@implementation CustomTableView
{
    resultsBlock result;
    BOOL firstFlag;
    NSInteger select_index;
}
-(instancetype)initWithFrame:(CGRect)frame result:(resultsBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        //创建tableview
        self.tableview = [MyBaseView myTableViewFrame:CGRectMake((frame.size.width-frame.size.height)/2, -(frame.size.width-frame.size.height)/2,frame.size.height, frame.size.width) style:UITableViewStylePlain delegate:self];
        self.tableview.rowHeight = 70*rateh;
        [self.tableview registerClass:[BaseCell class] forCellReuseIdentifier:@"cell"];
        self.tableview.transform = CGAffineTransformMakeRotation(-M_PI/2);
        [self addSubview:self.tableview];
        result = ^(NSInteger index, id obj){
            block(index,obj);
        };
    }
    return self;
}
//标题数组
-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    if (!firstFlag) {
        firstFlag = YES;
        if (_titleArr.count>0) {
            result(0,_titleArr.firstObject);
        }
    }
    [self.tableview reloadData];
}
//图片数组
-(void)setBoardImgArr:(NSArray *)boardImgArr{
    _boardImgArr = boardImgArr;
    if (!firstFlag) {
        firstFlag = YES;
        if (_boardImgArr.count>0) {
            result(0,_boardImgArr.firstObject);
        }
    }
    [self.tableview reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_boardImgArr.count>0) {
        return _boardImgArr.count;
    }else if(_titleArr.count>0){
        return _titleArr.count;
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    if (_boardImgArr.count>0) {

        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.layer.borderColor = YEllOWColor.CGColor;
        cell.selectedBackgroundView.layer.borderWidth = 2;

        NSDictionary *info = _boardImgArr[indexPath.row];
        NSURL *url = [NSURL URLWithString:info[@"original_image"]];
        cell.imageView.alpha = 1.0;
        [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"common_nopic"]];
        if (indexPath.row == 0) {
            
            //推荐标签的返参多余素材的返回参数，依据参数判断
            if (info.count >4) {
                cell.titleLabel.text = @"绘图板";

            }
            cell.titleLabel.textColor = YEllOWColor;
        }else {
            cell.titleLabel.text = @"";
        }
       
//    }
    }else if(_titleArr.count>0){
        if (indexPath.row == 0&&indexPath.section==0) {
            cell.selected = YES;
        }
        UIView *vie = [[UIView alloc] init];
        vie.backgroundColor = RGB(240, 240, 240);
        cell.selectedBackgroundView = vie;
        NSDictionary *info = _titleArr[indexPath.row];
//        cell.titleLabel.text = info[@"tag_name"];
        [cell setTitle:info[@"tag_name"]];
    }
    return cell;
}
//选择内容
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    select_index=indexPath.row;
     NSDictionary *info = [[NSDictionary alloc]init];
    info = _boardImgArr[indexPath.row];
    
   
    if (_titleArr.count>0) {
        info = _titleArr[indexPath.row];
    }
    
//    if (indexPath.row == 0&&indexPath.section==0) {
//        info = _boardImgArr[indexPath.row];
//    //添加本地图片
//    }
    result(indexPath.row,info);
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _titleArr.count>0?100*rateh:70*rateh;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{return nil;}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{return nil;}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

@end
