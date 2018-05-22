//
//  ZZadressViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZadressViewController.h"
#import "ZZOuTongTableViewCell.h"
#import "ZZAdressTableViewCell.h"
#import "ZZadresscellnameTableViewCell.h"

@interface ZZadressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *adressTableView;

@end

@implementation ZZadressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adressTableView.tableFooterView = [UIView new];
    [self.adressTableView registerNib:[UINib nibWithNibName:@"ZZAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"adress"];
    [self.adressTableView registerNib:[UINib nibWithNibName:@"ZZOuTongTableViewCell" bundle:nil] forCellReuseIdentifier:@"outong"];
       [self.adressTableView registerNib:[UINib nibWithNibName:@"ZZadresscellnameTableViewCell" bundle:nil] forCellReuseIdentifier:@"adresscell"];
    
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZZAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adress" forIndexPath:indexPath];
        // 2
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 3点击没有颜色改变
        cell.selected = NO;
        return cell;
    }else if(indexPath.section == 1){
        ZZadresscellnameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adresscell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        ZZOuTongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"outong" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else{
        return nil;
    }
}

-(void)tijiao{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ViewH/6;
    }else if (indexPath.section == 1){
        return ViewH/12;
    }else if (indexPath.section == 1){
        return ViewH/3*2;
    }else{
        return  0;
    }
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
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZadressViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"adressviewcon"];
        self = message;
    }
    return  self;
}
@end
