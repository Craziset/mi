//
//  ZZoneViewcellViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZoneViewcellViewController.h"
#import "ZZtwoTableViewCell.h"
#import "ZZtwosecondTableViewCell.h"
#import "CheappapeTableViewCell.h"
#import "XXCouponModel.h"
@interface ZZoneViewcellViewController ()
@property (weak, nonatomic) IBOutlet UITableView *oneTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ZZoneViewcellViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.oneTableView.tableFooterView = [UIView new];
    [self.oneTableView registerNib:[UINib nibWithNibName:@"ZZtwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"zz1"];
      [self.oneTableView registerNib:[UINib nibWithNibName:@"CheappapeTableViewCell" bundle:nil] forCellReuseIdentifier:@"zz2"];
    
    
    // Do any additional setup after loading the view.
    [self requestWithData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZZtwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zz1" forIndexPath:indexPath];
        // 2
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 3点击没有颜色改变
        cell.selected = NO;
        return cell;
    }else if(indexPath.section == 1){
        CheappapeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zz2" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
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
    if (indexPath.section == 0) {
        return  ViewH/8;
    }else{
      return   ViewH/7;
    }
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZoneViewcellViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"oneviewcell"];
        self = message;
    }
    return  self;
}


#pragma mark --- request

- (void)requestWithData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_id"] = USER_ID;
    dic[@"product_id"] = self.product_id;
    dic[@"quantity"] = self.countStr;
    dic[@"page"] = @1;
    dic[@"per_page"] = @20;
    [HWHttpTool post:API_BuyCoupons params:dic success:^(id json) {
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            self.dataArray = [XXCouponModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"data"]];
            if (self.dataArray.count == 0) {
                [ZJProgressHUD showStatus:@"你没有优惠券" andAutoHideAfterTime:1.1];
            }
            [self.oneTableView reloadData];
        }else
        {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:2.5];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
