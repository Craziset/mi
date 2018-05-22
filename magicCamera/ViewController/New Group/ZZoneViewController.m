//
//  ZZoneViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//  编辑收获地址

#import "ZZoneViewController.h"
#import "ZZoneadressTableViewCell.h"
#import "ZZoneViewlastTableViewCell.h"
#import "XXAddModel.h"
#import "XXAddAddressTableVC.h"
@interface ZZoneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //选中了第几个cell
    NSInteger _selectIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *oneTableview;
@property (nonatomic, strong) NSMutableArray *addArray;

@end

@implementation ZZoneViewController

- (NSMutableArray *)addArray
{
    if (!_addArray) {
        _addArray  = [NSMutableArray array];
    }
    return _addArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneTableview.tableFooterView = [UIView new];
    [self.oneTableview registerNib:[UINib nibWithNibName:@"ZZoneadressTableViewCell" bundle:nil] forCellReuseIdentifier:@"oneadress"];
        [self.oneTableview registerNib:[UINib nibWithNibName:@"ZZoneViewlastTableViewCell" bundle:nil] forCellReuseIdentifier:@"onecelll"];
    self.view.backgroundColor = BackColor;
    self.oneTableview.backgroundColor = BackColor;
    
    // Do any additional setup after loading the view.
    _selectIndex = 0;
    [self requestAddressList];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addArray.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.addArray.count) {
        ZZoneadressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneadress" forIndexPath:indexPath];
        cell.addModel = self.addArray[indexPath.section];
        // 2
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 3点击没有颜色改变
        if (indexPath.section == _selectIndex) {
            cell.SelateBtn.selected = YES;
            
            cell.backgroundColor = YEllOWColor;
            cell.LineLab.backgroundColor = [UIColor whiteColor];
        
        }else{
            cell.SelateBtn.selected = NO;
            cell.backgroundColor = [UIColor whiteColor];
            cell.LineLab.backgroundColor = YEllOWColor;
        }
        
        cell.addblock = ^(NSInteger select) {
            switch (select) {
                case 0://没选中
                    
                    break;
                case 1://选中
                {
                    _selectIndex = indexPath.section;
                    [self.oneTableview reloadData];
                }
                    break;
                case 2://删除
                {
                    if (self.addArray.count > 1) {
                        [self.addArray removeObjectAtIndex:indexPath.section];
                        [self.oneTableview reloadData];
                        [ZJProgressHUD showStatus:@"删除成功" andAutoHideAfterTime:1.1];
                    }else
                    {
                        [ZJProgressHUD showStatus:@"手下留情！" andAutoHideAfterTime:1.1];
                    }
                    
                }
                    break;
                case 3://编辑
                {
                    XXAddAddressTableVC *addTabVC = initVCFromSTBWithIdentifer(@"Main", @"XXAddAddressTableVC");
                    MJWeakSelf
                    addTabVC.addressBlock = ^(XXAddModel *addmodel) {
                        [weakSelf.addArray removeObjectAtIndex:indexPath.section];
                        [weakSelf.addArray insertObject:addmodel atIndex:indexPath.section];
                        [weakSelf.oneTableview reloadData];
                    };
                    [self.navigationController pushViewController:addTabVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            NSLog(@"%ld",select);
        };
        
        return cell;
    }else {
        ZZoneViewlastTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"onecelll" forIndexPath:indexPath];
        [cell.addButton addTarget:self action:@selector(addButton1) forControlEvents:UIControlEventTouchUpInside];
        [cell.defaultBtn addTarget:self action:@selector(defaultClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
#pragma 添加地址
-(void)addButton1{
    XXAddAddressTableVC *addTabVC = initVCFromSTBWithIdentifer(@"Main", @"XXAddAddressTableVC");
    MJWeakSelf
    addTabVC.addressBlock = ^(XXAddModel *addmodel) {
        [weakSelf.addArray addObject:addmodel];
        [weakSelf.oneTableview reloadData];
    };
    [self.navigationController pushViewController:addTabVC animated:YES];
    
}
#pragma 设置为默认地址
-(void)defaultClick{
    [ZJProgressHUD showStatus:@"设置成功" andAutoHideAfterTime:1 ];
    
}
-(void)tijiao{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < tableView.visibleCells.count - 1) {
        
//        for (NSInteger i = 0; i < self.addArray.count ; i ++) {
//            ZZoneadressTableViewCell *cell = tableView.visibleCells[i];
//            cell.SelateBtn.selected = NO;
//            cell.backgroundColor = [UIColor whiteColor];
//            cell.LineLab.backgroundColor = YEllOWColor;
//        }
//        ZZoneadressTableViewCell *cell = (ZZoneadressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        cell.SelateBtn.selected = YES;
//        cell.backgroundColor = YEllOWColor;
//        cell.LineLab.backgroundColor = [UIColor whiteColor];
        
        if (self.addModelBlock) {
            self.addModelBlock(self.addArray[indexPath.section]);
        }
        [self.navigationController popViewControllerAnimated:YES];
        //  这里当选择了新的地址时，就返回到上一下界面
//        ZZoneViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//
//        [self.navigationController popToViewController:vc animated:YES];
    }else
    {
        
    }  
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.addArray.count) {
        return 110.0f;
    }else if (indexPath.section == self.addArray.count){
        return 50;
    }else{
        return 0;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.editing = YES;
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
        ZZoneViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"onezz"];
        self = message;
    }
    return  self;
}
//请求地址列表
- (void)requestAddressList
{
    MJWeakSelf
    [ZJProgressHUD showProgress];
    [HWHttpTool post:API_AddressList params:@{@"user_id":USER_ID} success:^(id json) {
        [ZJProgressHUD hideHUD];
        NSLog(@"%@",json);
        [weakSelf.addArray removeAllObjects];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            if ([json[@"message"] isEqualToString:@"请添加收货地址"]) {
                [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            }else {
                weakSelf.addArray = [XXAddModel mj_objectArrayWithKeyValuesArray:json[@"result"]];
            }
        }
        [weakSelf.oneTableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ZJProgressHUD hideHUD];
    }];
}


@end
