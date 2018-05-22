//
//  ZZgoumaiViewController.m
//  magicCamera
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZgoumaiViewController.h"
#import "ZZAdressTableViewCell.h"
#import "ZZOuTongTableViewCell.h"
#import "ZZadressViewController.h"

#import "ZZkuaidiViewController.h"
#import "ZZoneViewcellViewController.h"

#import "ZZoneViewController.h"
#import "ZZkuaidiViewController.h"
#import "ZZfapiaoViewController.h"
#import "SongExpressVC.h"
#import "TicketControlViews.h"
#import "SongAdressTableViewCell.h"
#import "SongpayView.h"
#import "XXAddModel.h"
#import <AlipaySDK/AlipaySDK.h>
@interface ZZgoumaiViewController ()<UITableViewDelegate,UITableViewDataSource,PayDeletagte>
{
    UIView *BottomView;
    UIButton *DeiveLab;// 这里将cell里面的cell重新进行复制操作，将返回来的值添加上去
    BOOL _isAdd;//是否有地址
    NSString *_mac_id; //商铺id
}

@property (nonatomic, strong) XXAddModel *addModel;

@end

@implementation ZZgoumaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goumaiTableView.tableFooterView = [UIView new];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"ZZAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"adress"];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"ZZOuTongTableViewCell" bundle:nil] forCellReuseIdentifier:@"outong"];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"SongAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"SongAdressTableViewCell"];
    // Do any additional setup after loading the view.
    self.goumaiTableView.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"doc商品信息=====%@",_NextproductDic);
    
    [self requestStords];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     修改：2017.11.17
     ZZAdressTableViewCell 是无地址的时候cell
     #import "SongAdressTableViewCell.h"  //有收获地址的时候
     [self.goumaiTableView registerNib:[UINib nibWithNibName:@"ZZAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"adress"];
    */
    if (indexPath.section == 0) {   //
        if (!_isAdd) {
            ZZAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adress" forIndexPath:indexPath];
            [cell.button_adress addTarget:self action:@selector(button_adresscli) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 3点击没有颜色改变
            cell.selected = NO;
            return cell;
        }else
        {
            SongAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongAdressTableViewCell" forIndexPath:indexPath];
            cell.addModel = self.addModel;
            MJWeakSelf
            cell.clickBlock = ^{
                [weakSelf button_adresscli];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // 3点击没有颜色改变
            cell.selected = NO;
            return cell;
        }
        
    }else if(indexPath.section == 1){
        ZZOuTongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"outong" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ProductPic.image = _selectImage;
        if (self.isVC) { //购物车来的，应付
            cell.ProductName.text = @"米6";
            cell.SizeLab.text = [NSString stringWithFormat:@"商品型号：160 白色"];
            cell.ProductPrice.text = @"169";
            cell.ProductCount.text = [NSString stringWithFormat:@"X %@",_CountStr];
            cell.goodsPriceLabel.text = self.allPrice;
            //运费
            cell.freightLabel.text = [NSString stringWithFormat:@"￥0.00"];
            //总费用
            cell.totalPrice.text = self.allPrice;
        }else
        {
         //立即购买
            cell.ProductName.text = _NextproductDic[@"name"];
            cell.SizeLab.text = [NSString stringWithFormat:@"商品型号：%@  %@",_ZiseStr,_ColorStr];
            cell.ProductPrice.text = _NextproductDic[@"default_price"];
            //商品费用
            cell.goodsPriceLabel.text = [NSString stringWithFormat:@"%ld",[_NextproductDic[@"default_price"] integerValue] *[_CountStr integerValue]];
            //运费
            cell.freightLabel.text = [NSString stringWithFormat:@"￥0.00"];
            
            cell.totalPrice.text = [NSString stringWithFormat:@"%ld",[_NextproductDic[@"default_price"] integerValue] *[_CountStr integerValue]];
        }
        
        [cell.tijiaobutton addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *labelTapGestureRecognizerpeisong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick1pei)];
        [cell.peisongLabel addGestureRecognizer:labelTapGestureRecognizerpeisong];
        cell.peisongLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        DeiveLab = cell.peisongLabel; //这里将快递选择之后添加一个变量进行复制
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick1)];
        [cell.fapiaoxinxi addGestureRecognizer:labelTapGestureRecognizer];
        cell.fapiaoxinxi.userInteractionEnabled = YES; // 可以理解为设置label可被点击
           UITapGestureRecognizer *labelTapGestureRecognizern = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        [cell.nofapiao addGestureRecognizer:labelTapGestureRecognizern];
        cell.nofapiao.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick2)];
        [cell.youhuiquanlabel addGestureRecognizer:labelTapGestureRecognizer2];
        cell.youhuiquanlabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        return cell;
    }else{
        return nil;
    }
}
-(void)labelClick1pei{
    /*reason:此时是选择快递 之前是用xib进行画布的，笔法太粗躁了，
     tmie:2017.11.17进行修改处理
     @anthuor:song-yhb-wpw
    */
//    ZZkuaidiViewController *kuai = [[ZZkuaidiViewController alloc]init];
//    [self.navigationController pushViewController:kuai animated:YES];
        SongExpressVC *kuai = [[SongExpressVC alloc]init];//目录文件夹magicCamera/ViewController/ExpressControlViews
        kuai.timeString = ^(NSString *str){
            [DeiveLab setTitle:str forState:0];// 重新对选择快递进行赋值
        };
        [self.navigationController pushViewController:kuai animated:YES];
    
}
-(void)labelClick{ //发票管理
    /*reason:此时是选择快递 之前是用xib进行画布的，笔法太粗躁了，
     tmie:2017.11.17进行修改处理
     @anthuor:song-yhb-wpw
     路径：/magicCamera/ViewController/TicketControlViews
     ago:
     ZZfapiaoViewController *fapiao = [[ZZfapiaoViewController alloc]init];
     [self.navigationController pushViewController:fapiao animated:YES];
     */
    TicketControlViews *fapiao = [[TicketControlViews alloc]init];
    [self.navigationController pushViewController:fapiao animated:YES];
    
    
}
-(void)labelClick1{
    [self labelClick];
}

//优惠券
-(void)labelClick2{
    
    ZZoneViewcellViewController *couponsVC = [[ZZoneViewcellViewController alloc]init];
    couponsVC.product_id = _product_id;
    couponsVC.countStr = self.CountStr;
    [self.navigationController pushViewController:couponsVC animated:YES];
    
}
-(void)tijiao{  // 提交订单
//    ZZadressViewController *adress = [[ZZadressViewController alloc]init];
//    [self.navigationController pushViewController:adress animated:YES];
    
    SongpayView *po = [[SongpayView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)withStr:@"1233"];
    po.deleagte = self;
    [UIView animateWithDuration: 0.35 animations: ^{
        [po pop];
    } completion: nil];
    
    [self submitOrder];
    
    
}

#pragma marke--区别是支付宝还是微信

-(void)PayBtn:(NSString *)tag{
    
    NSLog(@"tag====%@",tag);
    
}

-(void)button_adresscli{ //点击添加地址 此时是无地址的时候
    ZZoneViewController *one = [[ZZoneViewController alloc]init];
    MJWeakSelf
    one.addModelBlock = ^(XXAddModel *addModel) {
        weakSelf.addModel = addModel;
        _isAdd = YES;
        [weakSelf.goumaiTableView reloadData];
    };
    [self.navigationController pushViewController:one animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ViewH/6;
    }else if (indexPath.section == 1){
        return ViewH/3*2.5;
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
        ZZgoumaiViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"goumai"];
        self = message;
    }
    return  self;
}

#pragma mark ---- 提交

- (void)submitOrder
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = USER_ID;
    params[@"product_id"] = self.product_id;
    params[@"color_name"] = self.ColorStr;
    params[@"size_name"] = self.ZiseStr;
    params[@"quantity"]= self.CountStr;
    params[@"platform"] = @"IOS";
    params[@"message"] = @"请快速寄出";
    params[@"send_type"] = @(1); //1邮寄2自取
    params[@"mac_id"] = _mac_id;
//    params[@"total_fee"] = self.
    

    
    [HWHttpTool post:API_BuyImmediately params:params success:^(id json) {
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
}
//商铺id
- (void)requestStords
{
    NSLog(@"%@",API_Stores);
    [HWHttpTool get:API_Stores params:nil success:^(id json) {
        _mac_id =[NSString stringWithFormat:@"%@",json[0][@"store_id"]];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)aliPay {
    NSString *appScheme = @"magicAli";
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = @"45678oiuhjkj";
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
    
    
}


@end
