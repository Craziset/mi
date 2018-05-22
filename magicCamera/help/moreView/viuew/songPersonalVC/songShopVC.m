//
//  songShopVC.m
//  magicCamera
//
//  Created by jianpan on 2017/11/13.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "songShopVC.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
//应付
#import "ZZgoumaiViewController.h"

@interface songShopVC ()<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate>
{
    NSInteger _count;//没用
    NSString *_mac_id;//店铺id
    BOOL _isEidt;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮
@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额
@property (nonatomic,strong) UIButton *deleteBtn;//删除按钮
@property(nonatomic,assign) float allPrice;

@end

@implementation songShopVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.allPrice = 0.00;
    [self createSubViews];
    [self requestData];
    //    [self shopCarClearing];
    _count = 2;
    _isEidt = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickEidtItem:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
}

- (void)clickEidtItem:(UIBarButtonItem *)item {
    
    _isEidt =!_isEidt;
    self.navigationItem.rightBarButtonItem.title = _isEidt?@"完成":@"编辑";
    self.deleteBtn.hidden = !_isEidt;
    self.totalMoneyLab.hidden = _isEidt;
    self.jieSuanBtn.hidden = _isEidt;
}


-(void)createSubViews{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH , SCREEN_HEIGHT -50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,self.tableView.bottom+(50-20)/2.0, 80, 25);
    //    [self.selectAllBtn setImage:[UIImage imageNamed:@"shop_deselect"] forState:UIControlStateNormal];
    //    [self.selectAllBtn setImage:[UIImage imageNamed:@"shop_select"] forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"shop_deselect"] forState:UIControlStateNormal];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"shop_select"] forState:UIControlStateSelected];
    [self.selectAllBtn setContentMode:(UIViewContentModeLeft)];
    
    [self.selectAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.selectAllBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    // self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.selectAllBtn];
    
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(SCREEN_WIDTH-GetWidth(184)-10,self.tableView.bottom+(50-GetHeight(74))/2.0,GetWidth(170), GetHeight(70));
    [self.jieSuanBtn setBackgroundColor:YEllOWColor];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    self.jieSuanBtn.layer.cornerRadius = 5.0;
    [self.jieSuanBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectArray.count] forState:(UIControlStateNormal)];
    
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.jieSuanBtn];
    
    self.deleteBtn = [[UIButton alloc]init];
    self.deleteBtn.frame = self.jieSuanBtn.frame;
    self.deleteBtn.layer.masksToBounds = YES;
    self.deleteBtn.layer.cornerRadius = 5.0;
    self.deleteBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.deleteBtn.layer.borderWidth = 1;
    [self.deleteBtn addTarget:self action:@selector(deleteShop) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.deleteBtn.hidden = YES;
    [self.view addSubview:self.deleteBtn];
    
    NSLog(@"%@",@(CGRectGetMinX(self.jieSuanBtn.frame)));
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jieSuanBtn.frame)-(SCREEN_WIDTH-self.selectAllBtn.right-30-GetWidth(184))-GetWidth(170), self.selectAllBtn.top, SCREEN_WIDTH-self.selectAllBtn.right-30-GetWidth(184),20)];
    
    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    [self.view addSubview:self.totalMoneyLab];
    
    
}
//结算
-(void)jieSuanAction{
    if (self.selectArray.count != 0) {
        ZZgoumaiViewController *gou = [[ZZgoumaiViewController alloc]init];
        
        gou.allPrice = [NSString stringWithFormat:@"%.2lf",self.allPrice];
        gou.shopModelArray = self.selectArray;
        gou.isVC = YES;
        [self.navigationController pushViewController:gou animated:YES];
    }else {
        [ZJProgressHUD showStatus:@"请选择商品" andAutoHideAfterTime:1.1];
    }
    NSLog(@"结算");
}
//全选
-(void)selectAllaction:(UIButton *)sender{
    
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
    }
    [self.selectArray removeAllObjects];
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        model.is_select = sender.tag;
        if (sender.tag == YES) {
            [self.selectArray addObject:model];
        }
    }
    [self CalculationPrice];
    [self.tableView reloadData];
    //全选
    [self shopCarCheckAllOrCanCel:sender.tag];
    [self.jieSuanBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectArray.count] forState:(UIControlStateNormal)];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr = @"ShopCarCell";
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        
    }
    cell.delegate = self;
    cell.shoppingModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    //    ShoppingModel *model = self.dataArray[indexPath.row];
    //    if (model.selectState)
    //    {
    //        model.selectState = NO;
    //    }
    //    else
    //    {
    //        model.selectState = YES;
    //    }
    //    //刷新当前行
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [self CalculationPrice];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            ShoppingModel *model = self.dataArray[index.row];
            if (model.quantity > 1)
            {
                model.quantity --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingModel *model = self.dataArray[index.row];
            model.quantity ++;
        }
            break;
        default:
            break;
    }
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}
//cell的选择
- (void)goodsCell:(UITableViewCell *)cell andSelect:(BOOL)select
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ShoppingModel *model = self.dataArray[index.row];
    model.is_select = select;
    
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (select) {
        [self.selectArray addObject:model];
    }else
    {
        [self.selectArray removeObject:model];
    }
    [self CalculationPrice];
    [self shopCarSelect:model.shop_car_id];
    [self.jieSuanBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectArray.count] forState:(UIControlStateNormal)];
    if (self.selectArray.count > 0 && self.selectArray.count == self.dataArray.count) {
        self.selectAllBtn.selected = YES;
    }
}

//计算价格
-(void)CalculationPrice
{
    self.allPrice = 0.00;
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.selectArray.count;i++)
    {
        ShoppingModel *model = self.selectArray[i];
        if (model.is_select)
        {
            self.allPrice = self.allPrice + model.quantity *[model.original_price intValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    NSLog(@"%f",self.allPrice);
    _count = self.allPrice /169;
    //    self.allPrice = 0.0;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --------------  数据请求 -----------------
//购物车列表
- (void)requestData
{
    [ZJProgressHUD showProgress];
    [afnObject POST:API_ShoppingCarList parameters:@{@"user_id":USER_ID} success:^(id responseObject) {
        [ZJProgressHUD hideHUD];
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            
            NSDictionary *dataDic = responseObject;
            self.dataArray = [ShoppingModel mj_objectArrayWithKeyValuesArray:dataDic[@"result"][@"goods"][@"vaild"]];
            for (ShoppingModel *model in self.dataArray) {
                if (model.is_select == 1) {
                    [self.selectArray addObject:model];
                    [self CalculationPrice];
                }
            }
            if (self.selectArray.count > 0 && self.selectArray.count == self.dataArray.count) {
                self.selectAllBtn.selected = YES;
            }
            
            [self.jieSuanBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",self.selectArray.count] forState:(UIControlStateNormal)];
        }else{
            [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:2.5f];
        }
        [self.tableView reloadData];
    } failure:^(id error) {
        [ZJProgressHUD hideHUD];
    } Cahche:NO];
}

//购物车选中
-(void)shopCarSelect:(NSString *)carId {
    [HWHttpTool post:API_ShopCarSelect params:@{@"user_id":USER_ID,@"shop_car_id":carId} success:^(id json) {
        NSLog(@"json:%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//全选或取消
-(void)shopCarCheckAllOrCanCel:(BOOL)check{
    NSString *str;
    if (check) {
        str = @"1";
    }else
    {
        str = @"0";
    }
    
    [HWHttpTool post:API_ShopCarCheckAll params:@{@"user_id":USER_ID,@"is_all_select":str} success:^(id json) {
        NSLog(@"json:%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//mac list
//商铺id
- (void)requestStords
{
    NSLog(@"%@",API_Stores);
    [HWHttpTool get:API_Stores params:nil success:^(id json) {
        _mac_id =[NSString stringWithFormat:@"%@",json[0][@"store_id"]];
    } failure:^(NSError *error) {
        
    }];
    
}
//购物车结算页
- (void)shopCarSubmit
{
    [HWHttpTool post:API_ShopCarSubmit params:@{@"user_id":USER_ID,@"mac_id":_mac_id} success:^(id json) {
        NSLog(@"json:%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//购物车结算
- (void)shopCarClearing {
    [HWHttpTool get:API_ShoppingCarSubmit params:@{@"user_id":USER_ID,@"mac_id":@"2017092853531004"} success:^(id json) {
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)deleteShop {
    NSMutableArray *idArr = [NSMutableArray arrayWithCapacity:0];
    for (ShoppingModel *model in self.selectArray) {
        [idArr addObject:model.product_id];
    }
    NSString *bodyStr = [SMGlobalMethod arrayToJson:idArr];
    MJWeakSelf
    [HWHttpTool post:API_ShopCarDelete params:@{@"user_id":USER_ID,@"body":bodyStr} success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            [weakSelf.dataArray removeObjectsInArray:weakSelf.selectArray];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



//

@end

