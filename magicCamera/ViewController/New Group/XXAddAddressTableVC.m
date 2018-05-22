//
//  XXAddAddressTableVC.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "XXAddAddressTableVC.h"
#import "XXProvinceTableViewController.h"
#import "XXAreasTableViewController.h"
#import "XXAddModel.h"

@interface XXAddAddressTableVC (){
    NSString *_countryStr;
    NSString *_provinceStr;
    NSString *_cityStr;
    NSString *_areaStr;
    
    NSString *_detailStr;
    NSString *_nameStr;
    NSString *_phoneStr;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *countryCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *cityCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *detailAddCell;
@property (weak, nonatomic) IBOutlet UITextField *detailAddTF;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITableViewCell *phoneCell;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)clickSaveAdd:(UIButton *)sender;

@property (nonatomic, strong) XXAreasTableViewController *areasVC;

@end

@implementation XXAddAddressTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _provinceStr = @"";
    self.areasVC = initVCFromSTBWithIdentifer(@"Main", @"XXAreasTableViewController");
    MJWeakSelf
    self.areasVC.addBlock = ^(NSString *provinceStr, NSString *cityName, NSString *pcaStr) {
        _provinceStr = provinceStr;
        _cityStr = cityName;
        _areaStr = pcaStr;
        weakSelf.cityCell.textLabel.text = [NSString stringWithFormat:@"%@%@%@",provinceStr,cityName,pcaStr];
        [weakSelf.tableView reloadData];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return self.countryCell;
            break;
        case 1:{
            
            return self.cityCell;
        }
            
            break;
        case 2:
            return self.detailAddCell;
            break;
        case 3:
            return self.nameCell;
            break;
        default:
            return self.phoneCell;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        XXProvinceTableViewController *proVC = initVCFromSTBWithIdentifer(@"Main", @"XXProvinceTableViewController");
        proVC.areasVC = self.areasVC;
        [self.navigationController pushViewController:proVC animated:YES];
    }
}

- (IBAction)clickSaveAdd:(UIButton *)sender {
    if ([XXJudgment stringWithNill:self.detailAddTF.text] ||[XXJudgment stringWithNill:self.nameTF.text] || [XXJudgment stringWithNill:self.phoneTF.text]) {
        [ZJProgressHUD showStatus:@"请完善信息" andAutoHideAfterTime:1.1];
    }else
    {
        
        [self requestNetworkAddAddress];
    }
}

- (void)requestNetworkAddAddress
{
    if ([_provinceStr isEqualToString:@""]) {
        [ZJProgressHUD showStatus:@"请完善信息" andAutoHideAfterTime:1.1];
    }else {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"user_id"] = USER_ID;
        params[@"consignee"] = self.nameTF.text;
        params[@"phone"] = self.phoneTF.text;
        params[@"country"] = @"中国";
        params[@"prov"] = _provinceStr;
        params[@"city"] = _cityStr;
        params[@"area"] = _areaStr;
        params[@"address"] = self.detailAddTF.text;
        MJWeakSelf
    
        [HWHttpTool post:API_AddAddress params:params success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                XXAddModel *addmodel = [XXAddModel mj_objectWithKeyValues:json[@"result"]];
                if (weakSelf.addressBlock) {
                    weakSelf.addressBlock(addmodel);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}



@end
