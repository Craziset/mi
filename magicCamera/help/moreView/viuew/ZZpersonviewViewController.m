//
//  ZZpersonviewViewController.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZpersonviewViewController.h"
#import "ZZpersonboneTableViewCell.h"
#import "ZZpersontwoTableViewCell.h"
#import "ZZpersonthreeTableViewCell.h"
#import "ZZdesignViewController.h"
#import "ZZsetnewViewController.h"
#import "ZZdingdanViewController.h"
#import "songShopVC.h"
#import "MyOderTalViewController.h"
#import "ChaperViewController.h"
#import "callpeopleview.h"
#import "MyselfViewController.h"
#import "sybPersonTwoTableViewCell.h"
#import "UIButton+WebCache.h"


#import "ZZProtocolViewController.h"
//Mine
#import "BaseTableViewController.h"
#import "MineTableViewController.h"

#import "ShopCellTableViewCell.h"

#import "ShoppingModel.h"
@interface ZZpersonviewViewController ()<UITableViewDataSource,UITableViewDelegate,ZZpersontwoTableViewCellTapDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SongBtnDetaleagte>
@property(nonatomic,strong)UIImage*avatar;

@property(nonatomic,strong)UIButton*imgBtn;
@property(nonatomic,strong)callpeopleview*callview;
@property (nonatomic,strong) UIButton *dianName;//修改名称
@property(nonatomic,strong)  NSMutableDictionary*dic;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZZpersonviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.personTableView registerNib:[UINib nibWithNibName:@"ZZpersonboneTableViewCell" bundle:nil] forCellReuseIdentifier:@"personone"];
    [self.personTableView registerNib:[UINib nibWithNibName:@"ZZpersontwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"personone2"];
    [self.personTableView registerNib:[UINib nibWithNibName:@"ZZpersonthreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"personone3"];

    [self.personTableView registerNib:[UINib nibWithNibName:@"ShopCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCellTableViewCell"];

    [self.personTableView registerClass:[sybPersonTwoTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.personTableView.tableHeaderView = [self setHeaderViewOfTableView];
    self.popView.frame = CGRectMake(ViewW, ViewH, ViewW, ViewH);
    [self.view addSubview:self.popView];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    __weak typeof(self) weakSelf = self;

    [self setHeaderViewOfTableView];
    [afnObject POST:API_ShoppingCarList parameters:@{@"user_id":USER_ID} success:^(id responseObject) {
        [ZJProgressHUD hideHUD];
        
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            
            NSDictionary *dataDic = responseObject;
            weakSelf.dataArray = [ShoppingModel mj_objectArrayWithKeyValuesArray:dataDic[@"result"][@"goods"][@"vaild"]];
//            for (ShoppingModel *model in self.dataArray) {
//                if (model.is_select == 1) {
////                    [self.selectArray addObject:model];
////                    [self CalculationPrice];
//                }
//            }
        }else{
            [XHToast showBottomWithText:responseObject[@"message"] bottomOffset:2.5f];
        }
        [weakSelf.personTableView reloadData];
    } failure:^(id error) {
        [ZJProgressHUD hideHUD];
    } Cahche:NO];
}
-(UIView *)setHeaderViewOfTableView{
    //取出本地缓存的用户头像
    ZZUserModel *model = [[ZZUserManager shareManager]userManager];
    _dic= [[NSUserDefaults standardUserDefaults]objectForKey:@"userinfo" ];
    NSString*imagestr=[NSString stringWithFormat:@"%@",_dic[@"avatar"]];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 170*rateh)];
    UIImageView*imgeview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 170*rateh)];
    imgeview.userInteractionEnabled=YES;
    imgeview.image=[UIImage imageNamed:@"headimg"];
    headerView.backgroundColor = [UIColor whiteColor];
    //头像
    _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn setBackgroundColor:[UIColor whiteColor]];
    _imgBtn.frame = CGRectMake(0, 20*rateh, 80, 80);
    
    _imgBtn.layer.masksToBounds =YES;
    [_imgBtn.layer setCornerRadius:40.0];//设置矩形四个圆角半径
    _imgBtn.centerX = headerView.centerX;
    [_imgBtn addTarget:self action:@selector(myselfinfo:) forControlEvents:UIControlEventTouchUpInside];
    [_imgBtn sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:nil];
    
    [imgeview addSubview:_imgBtn];
    //店名
    _dianName =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgBtn.frame)+20*rateh, kScreenW, 30*rateh)];
    _dianName.titleLabel.font = [UIFont systemFontOfSize:14*rateh];
    [_dianName setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_dianName addTarget:self action:@selector(myselfinfo:) forControlEvents:UIControlEventTouchUpInside];
    //    NSString*nickname=[NSString stringWithFormat:@"%@",_dic[@"nick_name"]];
    
    [_dianName setTitle:model.nick_name forState:UIControlStateNormal];
    
    
    [imgeview addSubview:_dianName];
    [headerView addSubview:imgeview];
    return headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            ZZpersonthreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personone3" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            return cell;
        }else{
            sybPersonTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.deletagte = self;
            return cell;
        }
    }else{
        if (indexPath.row == 0 && indexPath.section == 1) {
            ShopCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCellTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.badgeLab.text = [NSString stringWithFormat:@"%ld",self.dataArray.count];
            return cell;
        }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, ViewW, 50)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone; //显示最右边的箭头
        NSArray *array = @[@[[NSString stringWithFormat:@"我的购物车(%ld)",self.dataArray.count],@"我的优惠券",@"我的设计"],@[@"联系客服",@"帮助系统"],@[@"设置"]];
        NSArray*imgarr=@[@[@"setting4",@"setting5",@"setting6"],@[@"setting7",@"setting8"],@[@"setting9"]];
        UIImage * icon = [UIImage imageNamed:imgarr[indexPath.section-1][indexPath.row]];
        CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
        UIGraphicsEndImageContext();//*3
        cell.textLabel.text = array[indexPath.section-1][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        return cell;
        }
    }
}
-(void)viewDidLayoutSubviews {
    if ([self.personTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.personTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.personTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.personTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section == 0) {
    //        return ViewH/4;
    //    }else
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            return 50;
        }else{
            
                return 80*HEIGHT/kWJHeightCoefficient;
            
        }
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
#pragma cell的代理
-(void)tapZZpersontwoTableViewCell:(NSUInteger)tag{
    MyOderTalViewController *dingdan = [[MyOderTalViewController alloc]init];
    dingdan.StuatsTag = tag;
    [self.navigationController pushViewController:dingdan animated:YES];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"moreView" bundle:nibBundleOrNil];
        ZZpersonviewViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"person"];
        self = message;
    }
    return  self;
}

/*
 @anthor:song
 @修改：我的订单、我的购物车
 time：2017.11.14
 @reason：原工程太乱，将我的订单、我的购物车文件夹添加help-viuew目录文件下
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if (indexPath.row == 0) { // 我的订单
            MyOderTalViewController *dingdan = [[MyOderTalViewController alloc]init];
            dingdan.StuatsTag = 0;
            [self.navigationController pushViewController:dingdan animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {// 我的设计
            ZZdesignViewController *des = [[ZZdesignViewController alloc]init];
            [self.navigationController pushViewController:des animated:YES];
        }
        if (indexPath.row==0) {//我的购物车
            songShopVC *shop = [[songShopVC alloc]init];
            [self.navigationController pushViewController:shop animated:YES];
        }if (indexPath.row==1) {
            //优惠券
            ChaperViewController*chaperVC=[[ChaperViewController alloc]init];
            [self.navigationController pushViewController:chaperVC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {//电话客服
            //self.popView.frame = CGRectMake(0, 0, ViewW, ViewH);
            [self.view addSubview:self.callview];
        }
        if (indexPath.row == 1) {
            BaseTableViewController *vi =initVCFromSTBWithIdentifer(@"Main", [BaseTableViewController description]);
            [self.navigationController pushViewController:vi animated:YES];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ZZsetnewViewController *des = [[ZZsetnewViewController alloc]init];
            [self.navigationController pushViewController:des animated:YES];
        }
        
        
    }
}
- (IBAction)popViewclicked:(id)sender {
    self.popView.frame = CGRectMake(ViewW, ViewH, ViewW, ViewH);
}
-(void)SongBtnPerson:(UIButton *)sender{
    MyOderTalViewController *dingdan = [[MyOderTalViewController alloc]init];
    dingdan.StuatsTag = sender.tag+1;
    [self.navigationController pushViewController:dingdan animated:YES];
    
}
-(void)myselfinfo:(UIButton*)sender
{
    //点击个人中心昵称之后的详情页
    
    MineTableViewController *tab =initVCFromSTBWithIdentifer(@"Main", [MineTableViewController description]);
    MyselfViewController*myselfvc=[[MyselfViewController alloc]init];
    myselfvc.userdic=_dic;
    [self.navigationController pushViewController:tab animated:YES];
}
#pragma 上传头像
-(void)choseimage:(UIButton*)sender{
    [self alertOfHeaderImage];
}
-(void)alertOfHeaderImage{
    //初始化相册对象
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    pickerC.allowsEditing = YES;
    //初始化弹出视图
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //判断是否具有相机硬件
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //设置对应的数据源
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            //弹出相册
            [self presentViewController:pickerC animated:YES completion:^{
            }];
        }];
        [alertC addAction:action1];
    }else{
        NSLog(@"没有找到相机");
    }
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //设置对应的数据源类型
        pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //弹出相册
        [self presentViewController:pickerC animated:YES completion:^{
        }];
    }];
    [alertC addAction:action2];
    //初始化事件对象
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
#pragma 相册代理事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"editingInfo == %@",editingInfo);
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo  == %@",info);
    
    [_imgBtn setImage:info[@"UIImagePickerControllerEditedImage"] forState:UIControlStateNormal];
    _avatar = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    NSLog(@"%@",_avatar);
    //弹下去模态视图
    [self dismissViewControllerAnimated:YES completion:^{
        [self.personTableView reloadData];
        
    }];
    [self imagedata:_avatar];
}
//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}

//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma 上传头像接口
-(void)imagedata:(UIImage *)photo
{
    
    //    NSString *URL = [NSString stringWithFormat:@"%@//user/updavatar%@",SERVERURL,[DES3Util geturl]];
    //    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //
    //    [manager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //
    //        [formData appendPartWithFileData:UIImageJPEGRepresentation(photo, 1.0) name:@"file" fileName:@"file" mimeType:@"image/png"];
    //
    //    } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"%@",responseObject);
    //        _avatorModle=[AvatorModle mj_objectWithKeyValues:responseObject];
    //        if (_avatorModle.code==1) {
    //            [[NSUserDefaults standardUserDefaults]setObject:self.avatorModle.safeobj[@"safestring"] forKey:@"safestring"];
    //            NSString*nowstr=[NSString stringWithFormat:@"%@",self.avatorModle.safeobj[@"now"]];
    //            [[NSUserDefaults standardUserDefaults]setObject: nowstr forKey:@"now"];
    //
    //
    //
    //            NSMutableDictionary*dic= [[NSUserDefaults standardUserDefaults]objectForKey:@"userMessage" ];
    //            NSMutableDictionary*dic2=[dic mutableCopy];
    //            [dic2 setObject:_avatorModle.avatar forKey:@"avatar"];//保存的头像
    //
    //            [_tableView reloadData];
    //            [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"userMessage"];
    //        }if (_avatorModle.code==1006||_avatorModle.code==1007) {
    //            [[NSUserDefaults standardUserDefaults]setObject:self.avatorModle.safeobj[@"safestring"] forKey:@"safestring"];
    //
    //            NSString*nowstr=[NSString stringWithFormat:@"%@",self.avatorModle.safeobj[@"now"]];
    //            [[NSUserDefaults standardUserDefaults]setObject: nowstr forKey:@"now"];
    //
    //        }
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"123");
    //    }];
    
    
    
}
//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}
-(callpeopleview*)callview{
    if (!_callview) {
        _callview = [[callpeopleview alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        
    }
    return _callview;
}

@end

