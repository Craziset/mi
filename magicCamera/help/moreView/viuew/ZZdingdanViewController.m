//
//  ZZdingdanViewController.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZdingdanViewController.h"
#import "ZZdingdancellTableViewCell.h"

@interface ZZdingdanViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZZdingdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dingdantableView.tableFooterView = [UIView new];
      [self.dingdantableView registerNib:[UINib nibWithNibName:@"ZZdingdancellTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingdancell"];
    
    
    // Do any additional setup after loading the view.
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZdingdancellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dingdancell" forIndexPath:indexPath];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"moreView" bundle:nibBundleOrNil];
        ZZdingdanViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"dingdan"];
        self = message;
    }
    return  self;
}



@end
