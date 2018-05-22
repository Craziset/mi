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
#import "XXGoodTableViewCell.h"
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
#import "WXApi.h"
@interface ZZgoumaiViewController ()<UITableViewDelegate,UITableViewDataSource,PayDeletagte,WXApiDelegate>
{
    UIView *BottomView;
    UIButton *DeiveLab;// 这里将cell里面的cell重新进行复制操作，将返回来的值添加上去
    BOOL _isAdd;//是否有地址
    NSString *_mac_id; //商铺id
    NSString *_fapiao;
    
}

@property (nonatomic, strong) XXAddModel *addModel;

@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
//付款
- (IBAction)clickPaymentBtn:(UIButton *)sender;
//合计金额
@property (weak, nonatomic) IBOutlet UILabel *totUpLabel;
@property (nonatomic, strong) NSString *orderId;

@end

@implementation ZZgoumaiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.goumaiTableView.tableFooterView = [UIView new];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"ZZAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"adress"];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"ZZOuTongTableViewCell" bundle:nil] forCellReuseIdentifier:@"OuTongCell"];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"SongAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"SongAdressTableViewCell"];
    [self.goumaiTableView registerNib:[UINib nibWithNibName:@"XXGoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"XXGoodTableViewCell"];
    
    // Do any additional setup after loading the view.
    self.goumaiTableView.backgroundColor = [UIColor whiteColor];
    
    self.appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appdele.payDelegate = self;
    
    _fapiao = @"不开发票";
    
    if (!self.isVC) { //总费用
        
        self.allPrice = [NSString stringWithFormat:@"%ld",[self.productModel.original_price integerValue] * self.productModel.quantity +22];
    }else {
        self.allPrice = [NSString stringWithFormat:@"%ld",[self.allPrice integerValue]+22];
    }
    
    self.totUpLabel.text = [NSString stringWithFormat:@"合计:￥%@",self.allPrice];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ) {
        return 1;
    }else if (section == 1)
    {
        if (self.isVC) {
            return self.shopModelArray.count;
        }else return 1;
    }else
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
            cell.addModel = self.addModel ;
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
        
        XXGoodTableViewCell *goodscell = [tableView dequeueReusableCellWithIdentifier:@"XXGoodTableViewCell" forIndexPath:indexPath];
        goodscell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ShoppingModel *model = [ShoppingModel new];
        if (self.isVC) {
            model = self.shopModelArray[indexPath.row];
            [goodscell.productImageV sd_setImageWithURL:[NSURL URLWithString:model.thumbnail[0]] placeholderImage:[UIImage imageNamed:@"change_pic1_select"]];
        }else {
            model = self.productModel;
            [goodscell.productImageV sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[UIImage imageNamed:@"change_pic1_select"]];
        }
        goodscell.productNameLab.text  = model.product_temp_name;
        goodscell.sizeLab.text = [NSString stringWithFormat:@"商品型号:%@ %@",model.size_name,model.colour_name];
        goodscell.productpriceLab.text = [NSString stringWithFormat:@"￥ %@",model.original_price];
        goodscell.productCountLab.text = [NSString stringWithFormat:@"x %ld",model.quantity];
        goodscell.goodsPriceLab.text = [NSString stringWithFormat:@"￥ %ld",[model.original_price integerValue]* model.quantity];
        return goodscell;
        
    }else {
        ZZOuTongTableViewCell *ouTongcell = [tableView dequeueReusableCellWithIdentifier:@"OuTongCell" forIndexPath:indexPath];
        
        ouTongcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //运费
        ouTongcell.freightLabel.text = [NSString stringWithFormat:@"￥22.00"];
        
        ouTongcell.goodsPriceLabel.text =  [NSString stringWithFormat:@"￥ %ld",[self.allPrice integerValue]-22];
        ouTongcell.nofapiao.text = _fapiao;
        
        UITapGestureRecognizer *labelTapGestureRecognizerpeisong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick1pei)];
        [ouTongcell.peisongLabel addGestureRecognizer:labelTapGestureRecognizerpeisong];
        ouTongcell.peisongLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        DeiveLab = ouTongcell.peisongLabel; //这里将快递选择之后添加一个变量进行复制
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick1)];
        [ouTongcell.fapiaoxinxi addGestureRecognizer:labelTapGestureRecognizer];
        ouTongcell.fapiaoxinxi.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        UITapGestureRecognizer *labelTapGestureRecognizern = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        [ouTongcell.nofapiao addGestureRecognizer:labelTapGestureRecognizern];
        ouTongcell.nofapiao.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick2:)];
        ouTongcell.youhuiquanlabel.tag = 100 +indexPath.row;
        [ouTongcell.youhuiquanlabel addGestureRecognizer:labelTapGestureRecognizer2];
        ouTongcell.youhuiquanlabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        return ouTongcell;
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
    fapiao.block = ^(NSString *ticketStr) {
        _fapiao = ticketStr;
        [self.goumaiTableView reloadData];
    };
    [self.navigationController pushViewController:fapiao animated:YES];
    
    
}
-(void)labelClick1{
    [self labelClick];
}

//优惠券
-(void)labelClick2:(UITapGestureRecognizer *)gest{
    
    ShoppingModel *model = [ShoppingModel new];
    if (self.isVC) {
        model = self.shopModelArray[gest.view.tag - 100];
    }else
    {
        model = self.productModel;
    }
    ZZoneViewcellViewController *couponsVC = [[ZZoneViewcellViewController alloc]init];
    couponsVC.product_id = model.product_id;
    couponsVC.countStr = [NSString stringWithFormat:@"%ld",model.quantity];
    [self.navigationController pushViewController:couponsVC animated:YES];
    
}
-(void)tijiao{  // 提交订单
//    ZZadressViewController *adress = [[ZZadressViewController alloc]init];
//    [self.navigationController pushViewController:adress animated:YES];
    if (!_isAdd) {
        [ZJProgressHUD showStatus:@"请填写地址" andAutoHideAfterTime:1.1];
    }else
    {
        
        SongpayView *po = [[SongpayView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)withStr:self.allPrice];
        po.deleagte = self;

        [UIView animateWithDuration:0.3 animations:^{
            [po pop];
        } completion:^(BOOL finished) {
            [ZJProgressHUD showProgress];
            if (!self.isVC) {
                [self submitOrder];
            }else {
                [self creatOrderByShopCar];
            }
        }];
        
        
    }
    
    
    
}
- (IBAction)deleteClick:(id)sender {
    
    [XHToast showBottomWithText:@"删除成功" bottomOffset:150 duration:2.5f];

    [self.navigationController popToRootViewControllerAnimated:YES];

   
}
- (IBAction)phoneClick:(id)sender {
    
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSString *phoneNum = [NSString stringWithFormat:@"400-678-6788"];
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebView];
    
}

#pragma marke--区别是支付宝还是微信

-(void)PayBtn:(NSString *)tag{
    
    NSLog(@"tag====%@",tag);
    if ([XXJudgment stringWithNill:self.orderId]) {
        if (!self.isVC) {
            [self submitOrder];
        }else {
            [self creatOrderByShopCar];
        }
    }else {
        if ([tag integerValue] == 0) {
            [self aliPay];
        }else if ([tag integerValue] == 1) { //微信
            [self wxPay];
        }
    }
    
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
    }else if(indexPath.section == 1) {
        return 140;
        
    }else {
        return 270;
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
    //////
    params[@"product_id"] = self.productModel.product_id;
    params[@"colour_name"] = self.productModel.colour_name;
    params[@"size_name"] = self.productModel.size_name;
    params[@"quantity"]= @(self.productModel.quantity);
    //////
//    params[@"product_id"] = @"2017120410198100";
//    params[@"colour_name"] = @"白深蓝";
//    params[@"size_name"] = @"110";
//    params[@"quantity"]= @(1);
    
    params[@"platform"] = @"IOS";
    params[@"message"] = @"请快速寄出";
    params[@"send_type"] = @"1"; //1邮寄2自取
    params[@"mac_id"] = _mac_id;//店铺id
//    params[@"total_fee"] = self.allPrice;
    params[@"is_invoice"] = @"1"; //0 不开发票，1默认
    params[@"invoice_type"] = @"0";//0 普通发票
    params[@"invoice_list"] = @"0";//0 个人 1公司
    ///
    params[@"address_id"] = self.addModel.address_id;
    ///
//    params[@"address_id"] = @"68";
    ///
//    params[@"coupon_id"] = @"32456";
    params[@"delivery_time"] = @"0";//送货时间 0工作日 周六日 节假日均可 1 仅工作日 2 周六日 节假日
    NSLog(@"%@",params);
    MJWeakSelf
    //API_BuyImmediately
    //@"http://lz-geli.xin/api/v2/order/create-order-by-buy-immediately"
    [HWHttpTool post:API_BuyImmediately params:params success:^(id json) {
        NSLog(@"%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                weakSelf.orderId = [NSString stringWithFormat:@"%@",json[@"result"][@"order_id"]];
            }else{
                [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            }
        });
        
    } failure:^(NSError *error) {
        NSData * data = error.userInfo[@"com.alamofire.serialization.response"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
        
        NSLog(@"服务器的错误原因:%@",errorDic);
        
       
        [ZJProgressHUD hideHUD];
    }];
}

//购物车来提交
- (void)creatOrderByShopCar {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = USER_ID;
//    params[@"coupon_id"] =
    params[@"platform"] = @"IOS";
    params[@"message"] = @"请快速寄出";
    params[@"send_type"] = @"1"; //1邮寄2自取
    params[@"mac_id"] = _mac_id;//店铺id
    params[@"quantity"]= @(self.productModel.quantity);
    params[@"address_id"] = self.addModel.address_id;
    params[@"delivery_time"] = @"0";
    params[@"is_invoice"] = @"1"; //0 不开发票，1默认
    params[@"invoice_type"] = @"0";//0 普通发票
    params[@"invoice_list"] = @"0";//0 个人 1公司
    MJWeakSelf
    [HWHttpTool post:API_ShopCarOrder params:params success:^(id json) {
        NSLog(@"%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                weakSelf.orderId = [NSString stringWithFormat:@"%@",json[@"result"][@"order_id"]];
            }else{
                [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            }
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ZJProgressHUD hideHUD];
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

#pragma mark ---- 支付

- (void)aliPay {

    [ZJProgressHUD showProgress];
    MJWeakSelf
    [HWHttpTool post:API_AliPay params:@{@"user_id":USER_ID,@"order_id":self.orderId,@"platform":@"IOS"} success:^(id json) {
        NSLog(@"%@",json);
        [ZJProgressHUD hideHUD];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *appScheme = @"magicAli";
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = [NSString stringWithFormat:@"%@",json[@"result"][@"order_info"]];
                
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    
                }];
            });
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ZJProgressHUD hideHUD];
    }];
  
}

- (void)wxPay{
    [ZJProgressHUD showProgress];
    MJWeakSelf
    [HWHttpTool post:API_WXPay params:@{@"user_id":USER_ID,@"order_id":self.orderId,@"platform":@"IOS",@"trade_type":@"0"} success:^(id json) {
        [ZJProgressHUD hideHUD];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSDictionary *payDic = json[@"result"];
            PayReq *request = [[PayReq alloc] init];
            request.openID = payDic[@"appid"];
            request.partnerId = payDic[@"partnerId"];
            request.prepayId = payDic[@"prepay_id"];
            request.package = @"Sign=WXPay";
            request.nonceStr = payDic[@"nonceStr"];
            request.timeStamp= [payDic[@"timeStamp"] intValue];
            request.sign= payDic[@"sign"];
            // 调用微信
            [WXApi sendReq:request];

        }else
        {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
    } failure:^(NSError *error) {
        [ZJProgressHUD hideHUD];
    }];
}

#pragma mark - 支付回调
- (void)aliPayResult:(NSDictionary *)result
{
    if ([result[@"resultStatus"] integerValue] == 9000) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"恭喜你，支付成功" preferredStyle:(UIAlertControllerStyleAlert)];
        __weak typeof(self) weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    }else
    {
        [ZJProgressHUD hideHUD];
        [ZJProgressHUD showStatus:result[@"memo"] andAutoHideAfterTime:1.1];
    }
}

- (void)wxPaySuccesByResp:(BaseResp *)resp
{//启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:payResoult preferredStyle:(UIAlertControllerStyleAlert)];
        __weak typeof(self) weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (resp.errCode == 0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)clickPaymentBtn:(UIButton *)sender {
    [self tijiao];
}
@end
