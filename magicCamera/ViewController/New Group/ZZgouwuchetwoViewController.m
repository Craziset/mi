//
//  ZZgouwuchetwoViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZgouwuchetwoViewController.h"
#import "ZZtwogouwucheTableViewCell.h"

@interface ZZgouwuchetwoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *oneTableView;

@end

@implementation ZZgouwuchetwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.oneTableView.tableFooterView = [UIView new];
    [self.oneTableView registerNib:[UINib nibWithNibName:@"ZZtwogouwucheTableViewCell" bundle:nil] forCellReuseIdentifier:@"zz3"];

    
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZZtwogouwucheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zz3" forIndexPath:indexPath];
        // 2
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 3点击没有颜色改变
        cell.selected = NO;
        return cell;
    }else{
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return  ViewH/8;
    
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nibBundleOrNil];
        ZZgouwuchetwoViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"gouwuche"];
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
