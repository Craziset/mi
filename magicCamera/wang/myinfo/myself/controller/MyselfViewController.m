//
//  MyselfViewController.m
//  ww
//
//  Created by zxgy on 2017/11/16.
//  Copyright © 2017年 zxgy. All rights reserved.
//

#import "MyselfViewController.h"
#import "firstTableViewCell.h"
#import "secodTableViewCell.h"
#define kScreenS [UIScreen mainScreen].bounds
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define ratew  kScreenW/375.0
/// 高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度，如果你觉的它会变化，那我也很无奈
#define rateh   (kScreenH == 812.0 ? 667.0/667.0 : kScreenH/667.0)
@interface MyselfViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSArray*cellname;
@property(nonatomic,strong)NSArray*cellconcent;

@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellname=@[@"昵称",@"ID",@"性别",@"生日",@"邮箱",@"手机",@"城市",@"个性签名"];

    _cellconcent=@[@"米六六",@"6688",@"男",@"19920908",@"123458858@qq.com",@"127364646",@"北京市",@"未填写"];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableview];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return  2;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }return 8;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80*rateh;
    }return 44*rateh;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        firstTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"firstTableViewCell"];
        [cell.usericon sd_setImageWithURL:[NSURL URLWithString:_userdic[@"avatar"]]];
        return cell;
    }
    secodTableViewCell*seccell=[tableView dequeueReusableCellWithIdentifier:@"secodTableViewCell"];
    seccell.titlelab.text=_cellname[indexPath.row];
    if (indexPath.row==0) {
        seccell.contentlab.text=[NSString stringWithFormat:@"%@",_userdic[@"nick_name"]];
    }
    return seccell;


}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor whiteColor];
        [_tableview registerNib:[UINib nibWithNibName:@"firstTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstTableViewCell"];
         [_tableview registerNib:[UINib nibWithNibName:@"secodTableViewCell" bundle:nil] forCellReuseIdentifier:@"secodTableViewCell"];
    }
    return _tableview;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
