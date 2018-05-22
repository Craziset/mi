//
//  ChaperViewController.m
//  magicCamera
//
//  Created by Myself on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ChaperViewController.h"
//我的优惠券
#import "cheapHeadview.h"
#import "CheappapeTableViewCell.h"
#import "XXCouponModel.h"
@interface ChaperViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int ToalPage;
    int page;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ChaperViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self tableViewDidTriggerHeaderRefresh];
    }];
    self.tableview.mj_header.accessibilityIdentifier = @"refresh_header";
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self tableViewDidTriggerFooterRefresh];
    }];
    self.tableview.mj_footer.accessibilityIdentifier = @"refresh_footer";
    [self.tableview.mj_header beginRefreshing];
    
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10*rateh;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }else return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  ViewH/7;
    }else{
        return   ViewH/7;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheappapeTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CheappapeTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    XXCouponModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 130*rateh;
//}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH-SafeAreaTopHeight) style:UITableViewStylePlain];

        _tableview.backgroundColor=[UIColor whiteColor];
        
                _tableview.dataSource=self;
                _tableview.delegate=self;
                [_tableview registerNib:[UINib nibWithNibName:@"CheappapeTableViewCell" bundle:nil] forCellReuseIdentifier:@"CheappapeTableViewCell"];
                _tableview.tableHeaderView = [self setHeaderOfTableView];
           _tableview.tableFooterView = [[UIView alloc] init];
        
            }
            return _tableview;
        }
-(UIView*)setHeaderOfTableView{
    cheapHeadview*chapeview=[[cheapHeadview alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 130*rateh)];
    
    return chapeview;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footview = [[UIView alloc]init];
    footview.backgroundColor = [UIColor whiteColor];
    return footview;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = @"选择优惠券";
        label.font = [UIFont systemFontOfSize:15];
        return label;
    }else
    {
        return [UIView new];
    }
}

-(void)requstData{
    NSDictionary *dicPar = @{
                             @"user_id":USER_ID,
                             @"page":[NSString stringWithFormat:@"%d",page],
                             @"per_page":@10,
                             @"type":@"canUse"
                             };
    [afnObject POST:API_Coupons parameters:dicPar success:^(id responseObject) {
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            if (page == 1) {
                [_dataArray removeAllObjects];
            }
            NSArray *array = [XXCouponModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            [_dataArray addObjectsFromArray:array];
            ToalPage = [responseObject[@"result"][@"total_page"] intValue];
        }else{
            [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:2.5f];
        }
        [self.tableview reloadData];
    } failure:^(id error) {
    } Cahche:NO];
}

//设置刷新视图
-(void)tableViewDidTriggerHeaderRefresh{
    //2.模拟刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        page = 1;
        [self requstData];
    });
}

//设置加载尾视图
-(void)tableViewDidTriggerFooterRefresh{
    page = page +1;
    if (page > ToalPage) {
        [XHToast showBottomWithText:@"加载完成" bottomOffset:150 duration:1.0f];
        [_tableview.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self requstData];
    }
}


@end
