//
//  ZZpersonmessageViewController.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZpersonmessageViewController.h"
#import "ZZpermesTwoTableViewCell.h"
#import "ZZpermesoneTableViewCell.h"

@interface ZZpersonmessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *messageArray;
@property(nonatomic,strong)NSArray *textmessageArray;
@end

@implementation ZZpersonmessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.permesTableView.tableFooterView = [UIView new];
    [self.permesTableView registerNib:[UINib nibWithNibName:@"ZZpermesoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"percell1"];
    [self.permesTableView registerNib:[UINib nibWithNibName:@"ZZpermesTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"percell2"];
    
    self.messageArray = @[@"头像",@"昵称",@"ID",@"性别",@"生日",@"邮箱",@"手机",@"城市",@"个性签名"];
    self.textmessageArray = @[@"小小的稻草",@"m686888888",@"男",@"2000年9月5日",@"1306700263@qq.com",@"178*******8",@"西门子",@"i am  wrong"];
    
    // Do any additional setup after loading the view.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZZpermesoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"percell1" forIndexPath:indexPath];
        cell.zuoLabel.text = self.messageArray[indexPath.row];
        
        return cell;
    }else{
       ZZpermesTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"percell2" forIndexPath:indexPath];
        cell.zuoLabel.text = self.messageArray[indexPath.row];
        cell.youTextField.text = self.textmessageArray[indexPath.row-1];
    
    return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"moreView" bundle:nibBundleOrNil];
        ZZpersonmessageViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"perMessage"];
        self = message;
    }
    return  self;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
