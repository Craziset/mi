//
//  ZZSureMerViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//  选品之后确定购买

#import "ZZSureMerViewController.h"
#import "ZZgoumaiViewController.h"
#import "ZZgouwuchetwoViewController.h"
#import "ChoseView.h"
@interface ZZSureMerViewController ()<UITextFieldDelegate,TypeSeleteDelegete,SongColorTypeSeleteDelegete,MerchOrButteDetelagte,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLConnectionDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    ChoseView *choseView;
    UIView *bgview;
    CGPoint center;
    NSMutableArray *sizearr;//型号数组
    NSMutableArray *colorarr;//分类数组
    int buyCount;
    /*
     选择商品信息
     */
    NSString *ZiseStr;//商品的尺码
    NSString *ColorStr;//商品颜色
    NSString *CountStr;//商品的数量
    NSString *_imageUrl;
    UIImageView *MiddImg;
    
    NSData *_imagedata;
    dispatch_group_t _group;
    
    NSString *_product_id;
    
}

@property (weak, nonatomic) IBOutlet UILabel *setp3;
@property (weak, nonatomic) IBOutlet UILabel *setp4;

//更换的图片
@property (nonatomic, strong) UIImage *newimage;

@property (weak, nonatomic) IBOutlet UIButton *NextBtn;

@property (weak, nonatomic) IBOutlet UIButton *changeImageBtn;

@property (weak, nonatomic) IBOutlet UIButton *reductionBtn;//还原
//换图
- (IBAction)clickChangeImage:(UIButton *)sender;
//还原
- (IBAction)clickReductionBtn:(UIButton *)sender;


@end

@implementation ZZSureMerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZiseStr = @"";
    ColorStr = @"";
    self.NextBtn.layer.cornerRadius = 5.0f;
    self.view.userInteractionEnabled = YES;
    
    
    
    self.changeImageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.changeImageBtn.layer.cornerRadius = 3;
    self.changeImageBtn.layer.borderWidth = 1;
    
    self.reductionBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.reductionBtn.layer.cornerRadius = 3;
    self.reductionBtn.layer.borderWidth = 1;

    self.choseImageView.image = self.tShirtImage;
    // Do any additional setup after loading the view.
    /**
     这些数据应该从服务器获得 没有服务器我就只能先写死这些数据了
     */
    sizearr = [NSMutableArray arrayWithCapacity:0];
    colorarr  = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *dic = @{@"product_template_id":_NextproductDic[@"product_temp_id"]};
    NSLog(@"_product_temp_id======%@",dic);
    [self requstSize:dic];
    [self requstColor:dic];
    
    self.choseImageView.userInteractionEnabled = YES;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    backView.userInteractionEnabled = YES;
    [self.choseImageView addSubview:backView];
    
    MiddImg = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-160*rateh)/2, (WIDTH-160*rateh)/2, 160*rateh, 160*rateh)];
    MiddImg.image = _selectImage;
    MiddImg.center  = CGPointMake(backView.center.x-35, backView.center.y + 10) ;
    [backView addSubview:MiddImg];
    //
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = RGBA(107, 188, 99, 1).CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:MiddImg.bounds].CGPath;
    border.frame = MiddImg.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [MiddImg.layer addSublayer:border];
    
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    [backView addGestureRecognizer:pan];
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [backView addGestureRecognizer:pinch];
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    [backView addGestureRecognizer:rotation];
}

//移动手势
-(void)removeTap:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);//    限制屏幕范围：
    newCenter.y = newCenter.y;
    newCenter.y =newCenter.y;
    newCenter.x = newCenter.x;
    newCenter.x = newCenter.x;
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];
}
//捏合
-(void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    if (scale>=1) {
        if (recognizer.view.frame.size.width<WIDTH*2) {
            recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
        }
    }else{
        if (recognizer.view.frame.size.width>WIDTH*0.3) {
            recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
        }
    }
    recognizer.scale = 1.0;
}
//旋转
-(void)handleRotation:(UIRotationGestureRecognizer *)recognizer{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0.0;
}

// 请求尺寸和颜色的数据
-(void)requstSize:(NSDictionary *)dic{
    [afnObject POST:[NSString stringWithFormat:@"%@%@",SongMainUrl,@"api/product-temp/product-template-sizes"] parameters:dic success:^(id responseObject) {
        NSLog(@"size======%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            [sizearr addObject:dic[@"size_name"]];
        }
    } failure:^(id error) {
    } Cahche:NO];
}
// 请求颜色的数据
-(void)requstColor:(NSDictionary *)dic{
    [afnObject POST:[NSString stringWithFormat:@"%@%@",SongMainUrl,@"api/product-temp/product-template-colors"] parameters:dic success:^(id responseObject) {
        NSLog(@"size======%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            [colorarr addObject:dic[@"colour_name"]];
        }
        
    } failure:^(id error) {
    } Cahche:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)maibutton:(id)sender {
    
    ZZgoumaiViewController *gou = [[ZZgoumaiViewController alloc]init];
    [self.navigationController pushViewController:gou animated:YES];
    
}


- (IBAction)gouwuche:(id)sender {
    
    
}

- (IBAction)gouwucheclicked:(id)sender { //点击加入购物车
    
    //    ZZgouwuchetwoViewController *gou = [[ZZgouwuchetwoViewController alloc]init];
    //    [self.navigationController pushViewController:gou animated:YES];
    
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZSureMerViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"suremre"];
        self = message;
    }
    return  self;
}

- (IBAction)nextButton:(id)sender { // 点击下一步是弹出选择型号
    /*
     @anthor:song
     reason:由于原型图是xib，xib并且是用label上，没有一点的逻辑而言，现在要重新选择进行写一个弹出视图
     路径：magicCamera/ViewController/songCreatOrder/songPopMeau
     time：2017.11.15
     */
    [self clickNextStep];
    self.setp3.backgroundColor = [UIColor whiteColor];
    self.setp3.textColor = [UIColor blackColor];
    self.setp4.backgroundColor = YEllOWColor;
    self.setp4.textColor = [UIColor whiteColor];
    
}
// 选择尺寸，规则 加入购物车和直接购买
/**
 *  初始化弹出视图
 */
-(void)initChoseView
{
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    choseView.deleteagte = self;
    [self.view addSubview:choseView];
    
    
    choseView.img.text = _NextproductDic[@"name"];
    choseView.lb_price.text = [NSString stringWithFormat:@"¥ %@",_NextproductDic[@"default_price"]];
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    
    //颜色分类
    choseView.colorView = [[SongColorView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
    
    //购买数量
    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    
}
/**
 *  点击尺寸弹出
 */
-(void)btnindex:(int)tag{
    ZiseStr = sizearr[tag];
    NSLog(@"尺寸=========%d",tag);
    
}
/**
 *  点击颜色弹出
 */
-(void)SongColorbtnindex:(int)tag{
    ColorStr = colorarr[tag];
    NSLog(@"颜色=========%d",tag);
    
}
/**
 *  点击是购买还是加入购物车
 */
-(void)btnMerchOrButte:(UIButton *)btn{
    if (![ZiseStr isEqual:@""]&&![ColorStr isEqual:@""]) {
    buyCount = [choseView.countView.tf_count.text intValue]; //选择的数量
    if ([btn.titleLabel.text isEqualToString:@"立即购买"]) {
        ZZgoumaiViewController *gou = [[ZZgoumaiViewController alloc]init];
        gou.selectImage = [self createImg:self.choseImageView];
        gou.ZiseStr = ZiseStr;
        gou.ColorStr = ColorStr;
        gou.CountStr = choseView.countView.tf_count.text;
        gou.product_id = _product_id;
        gou.NextproductDic = _NextproductDic;//产品的信息
        
        [self.navigationController pushViewController:gou animated:YES];
    }else{  // 加入购物车
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"user_id"] = @"11112";
        dic[@"product_id"] = _product_id;
        dic[@"colour_name"] = ColorStr;
        dic[@"size_name"] = ZiseStr;
        MJWeakSelf
        [afnObject POST:API_AddShoppingCar parameters:dic success:^(id responseObject) {
            [ZJProgressHUD hideAllHUDs];
            if([responseObject[@"state"] isEqualToString:@"M00000"]) {
                [weakSelf dismiss];
            
                [ZJProgressHUD showStatus:@"添加成功" andAutoHideAfterTime:1.1];
            }else
            {
                [ZJProgressHUD showStatus:responseObject[@"message"] andAutoHideAfterTime:1.1];
            }
            
        } failure:^(id error) {
        } Cahche:NO];
        
     }
    }else{
        NSLog(@"ddfffff");
        [XHToast showTopWithText:@"请选择信息" topOffset:100 duration:2.5];
    }
}
//生成图片
-(UIImage *)createImg:(UIView *)view{
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  点击按钮弹出
 */
-(void)btnselete
{
    [UIView animateWithDuration: 0.35 animations: ^{
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
        choseView.center = self.view.center;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    
    self.setp3.backgroundColor = YEllOWColor;
    self.setp3.textColor = [UIColor whiteColor];
    self.setp4.backgroundColor = [UIColor whiteColor];
    self.setp4.textColor = [UIColor blackColor];
    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        bgview.center = self.view.center;
    } completion: nil];
    
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}

- (void)clickNextStep
{
    UIGraphicsBeginImageContextWithOptions(self.choseImageView.bounds.size, NO, 0.0);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _imagedata = UIImagePNGRepresentation(viewImage);
    [self initChoseView];
    [self btnselete];
    MJWeakSelf
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
         _group = dispatch_group_create();
        dispatch_group_async(_group, queue, ^{
            [weakSelf uploadToImage];
        });

        dispatch_group_notify(_group, queue, ^{
            [weakSelf createProduct];
        });
    });
 }
//生成商品
- (void)createProduct
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_id"] = @"11112";
    dic[@"product_temp_id"] = _NextproductDic[@"product_temp_id"];
    _imageUrl = [_imageUrl substringFromIndex:1];
    dic[@"product_image"] = API_UploadImageURL(_imageUrl) ;
    //
    [afnObject POST:API_CreateProduct parameters:dic success:^(id responseObject) {
        [ZJProgressHUD hideAllHUDs];
        _product_id = [NSString stringWithFormat:@"%@",responseObject[@"product_id"]];
        
        
    } failure:^(id error) {
        NSLog(@"%@",error);
    } Cahche:NO];
    
}

- (void)uploadToImage
{
    
    dispatch_group_enter(_group);
    [HWHttpTool post:API_ImageUpload params:nil fileDatas:@[_imagedata] name:@"finished" fileNames:@[@"finished.png"] mimeTypes:@[@"image/png"] success:^(id json) {
        NSLog(@"%@",json);
        NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"data"]];
        _imageUrl = imageUrl;
        dispatch_group_leave(_group);
    } failure:^(NSError *error) {
        dispatch_group_leave(_group);
        NSLog(@"%@",error);
    }];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [MiddImg setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickChangeImage:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)clickReductionBtn:(UIButton *)sender {
    [MiddImg setImage:self.selectImage];
}
@end

