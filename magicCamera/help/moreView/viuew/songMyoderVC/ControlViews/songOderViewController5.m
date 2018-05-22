//
//  songOderViewController5.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "songOderViewController5.h"
#import "SongMypderTableViewHeader.h"
#import "SongOrderTableViewCell.h"
#import "SongHeadmodel.h"
#import "SongOrderTablemodel.h"
#import "SongFootView.h"
@interface songOderViewController5 ()<UITableViewDelegate,UITableViewDataSource>{
    int ToalPage;
    int page;
}
@property(nonatomic,strong)UITableView *Songtab;
@property(nonatomic,strong)NSMutableArray *SuperArrSong;//section 对象数组
@property(nonatomic,strong)NSMutableArray *ObjectArrSong; //row对象数组
@end
@implementation songOderViewController5
-(NSMutableArray *)SuperArrSong{
    if (_SuperArrSong ==nil) {
        self.SuperArrSong = [NSMutableArray arrayWithCapacity:0];
    }
    return _SuperArrSong;
}
-(NSMutableArray *)ObjectArrSong{
    if (_ObjectArrSong ==nil) {
        self.ObjectArrSong = [NSMutableArray arrayWithCapacity:0];
    }
    return _ObjectArrSong;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.Songtab];
    [self setUpTableView];
}
-(void)Requst:(int)tag{
    NSDictionary *dicPar = @{
                             @"user_id":USER_ID,
                             @"page":[NSString stringWithFormat:@"%d",page],
                             @"per_page":@10
                             };
    
    //api/order/user-order-complete
    [afnObject POST:API_OrderAftermark parameters:dicPar success:^(id responseObject) {
        [_Songtab.mj_header endRefreshing];
        [_Songtab.mj_footer endRefreshing];
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            [self requstData:responseObject[@"result"] withTag:tag];
            ToalPage = [responseObject[@"result"][@"total_page"] intValue];
        }else{
            [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:2.5f];
        }
    } failure:^(id error) {
    } Cahche:NO];
}
-(void)requstData:(NSDictionary *)dicData withTag:(int)tag{
    if (tag==0) {
        self.SuperArrSong = nil;
        self.ObjectArrSong = nil;
    }
    self.SuperArrSong = [SongHeadmodel mj_objectArrayWithKeyValuesArray:dicData[@"data"]];
//    for (NSDictionary *dic in dicData[@"data"]) {
//        SongHeadmodel *model = [SongHeadmodel modelWithDictionary:dic];
//        [self.SuperArrSong addObject:model];
//        for (NSDictionary *dic1 in dic[@"goods"][@"vaild"]) {
//            SongOrderTablemodel *modelOrder = [SongOrderTablemodel modelWithDictionary:dic1];
//            [self.ObjectArrSong addObject:modelOrder];
//        }
//    }
    [self.Songtab reloadData];
}
#pragma mark-tab
-(UITableView *)Songtab{
    if (_Songtab==nil) {
        _Songtab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT-110*HEIGHT/XMultiple) style:UITableViewStyleGrouped];
        _Songtab.delegate = self;
        _Songtab.dataSource = self;
        [_Songtab setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
        [_Songtab setSeparatorColor:[UIColor colorWithHexString:@"#f0f0f0"]];
    }
    return _Songtab;
}
#pragma mark-tab-delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SongHeadmodel *model = self.SuperArrSong[section];
    return model.vaild.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.SuperArrSong.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}
#pragma 头视图和脚视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 85;
}
-(SongFootView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{  //SongFootView
    static  NSString *identifiter = @"SongFootView";
    SongFootView *foot =[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifiter];
    if (foot==nil) {
        foot = [[SongFootView alloc]initWithReuseIdentifier:identifiter];
    }
    [foot configureCellWithModel:self.SuperArrSong[section]];
    foot.contentView.backgroundColor = [UIColor whiteColor];
    foot.StusBtn1.tag = section;
    foot.StusBtn2.tag = section;
    foot.FirstGoundBtn.tag = section;
    foot.FirstGoundBtn1.tag = section;
    [foot.StusBtn1 addTarget:self action:@selector(footBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [foot.StusBtn2 addTarget:self action:@selector(footBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [foot.FirstGoundBtn addTarget:self action:@selector(footServiceBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [foot.FirstGoundBtn1 addTarget:self action:@selector(footCancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    foot.FirstGoundBtn1.hidden = YES;
    return foot;
}
-(SongMypderTableViewHeader *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static  NSString *identifiter = @"MyOderTableViewCell1";
    SongMypderTableViewHeader *head =[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifiter];
    if (head==nil) {
        head = [[SongMypderTableViewHeader alloc]initWithReuseIdentifier:identifiter];
    }
    [head configureCellWithModel:self.SuperArrSong[section]];
    head.contentView.backgroundColor = [UIColor whiteColor];
    return head;
}
-(SongOrderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"cell12555";
    SongOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell==nil) {
        cell = [[SongOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiter];
    }
    SongHeadmodel *headModel = self.SuperArrSong[indexPath.section];
    cell.model = headModel.vaild[indexPath.row];
//    [cell configureCellWithModel:self.ObjectArrSong[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark-加载上拉刷新，下拉加载
-(void)setUpTableView{
    _Songtab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self tableViewDidTriggerHeaderRefresh];
    }];
    _Songtab.mj_header.accessibilityIdentifier = @"refresh_header";
    _Songtab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self tableViewDidTriggerFooterRefresh];
    }];
    _Songtab.mj_footer.accessibilityIdentifier = @"refresh_footer";
    [_Songtab.mj_header beginRefreshing];
}
//设置刷新视图
-(void)tableViewDidTriggerHeaderRefresh{
    //2.模拟刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        page = 1;
        [self Requst:0];
    });
}
//设置加载尾视图
-(void)tableViewDidTriggerFooterRefresh{
    page = page +1;
    if (page > ToalPage) {
        [XHToast showBottomWithText:@"加载完成" bottomOffset:150 duration:1.0f];
        [_Songtab.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self Requst:1];
    }
}
#pragma mark-点击下面的订单事件

- (void)footServiceBtnEvent:(UIButton *)sender
{
    NSLog(@"联系客服");
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSString *phoneNum = [NSString stringWithFormat:@"400-678-6788"];
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebView];
}

- (void)footCancelBtnEvent:(UIButton *)sender
{
    //这里应该是删除订单，可是好像没有接口，暂用取消
    
    [ZJProgressHUD showProgress];
    NSDictionary *dic = @{@"user_id":USER_ID,@"order_id":[self.SuperArrSong[sender.tag] order_id]};
    [afnObject POST:API_OrderCancle parameters:dic success:^(id responseObject) {
        [ZJProgressHUD hideAllHUDs];
        if([responseObject[@"state"] isEqualToString:@"M00000"]) {
            [self tableViewDidTriggerHeaderRefresh];
        }
        [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:150 duration:2.5f];
    } failure:^(id error) {
    } Cahche:NO];
}


-(void)footBtnEvent:(UIButton *)seder{
    NSDictionary *DicStr = @{
                             @"取消":@"order/order-cancel",
                             @"付款":@"0",
                             @"确认收货":@"order/order-sign",
                             @"查看订单":@"1",
                             @"查看物流":@"2",
                             @"提醒发货":@"order/order-urge"
                             };
    if ([DicStr[seder.titleLabel.text] isEqualToString:@"0"]||[DicStr[seder.titleLabel.text] isEqualToString:@"1"]||[DicStr[seder.titleLabel.text] isEqualToString:@"2"]) {
        switch ([DicStr[seder.titleLabel.text] intValue]) {
            case 0:
            {
                NSLog(@"btn.text====%@",DicStr[seder.titleLabel.text]);
            }break;
            case 1:
            {
                NSLog(@"btn.text====%@",DicStr[seder.titleLabel.text]);
            }break;
            case 2:
            {
                NSLog(@"btn.text====%@",DicStr[seder.titleLabel.text]);
            }break;
        }
    }else{
        SongHeadmodel *model = [[SongHeadmodel alloc]init];
        model = self.SuperArrSong[seder.tag];
        NSDictionary *dic = @{
                              @"user_id":USER_ID,
                              @"order_id":model.Orderorder_idStr
                              };
        NSLog(@"btn.text====%@",DicStr[seder.titleLabel.text]);
        [self requstFootEvent:DicStr[seder.titleLabel.text] withOrderNo:dic];
    }
}
-(void)requstFootEvent:(NSString *)str withOrderNo:(NSDictionary *)dic{
    [ZJProgressHUD showProgress];
    [afnObject POST:[NSString stringWithFormat:@"%@%@",SongMainUrl,str] parameters:dic success:^(id responseObject) {
        [ZJProgressHUD hideAllHUDs];
        if([responseObject[@"state"] isEqualToString:@"M00000"]) {
            [self tableViewDidTriggerHeaderRefresh];
        }
        [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:150 duration:2.5f];
    } failure:^(id error) {
    } Cahche:NO];
}
@end
