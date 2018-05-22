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
#import "XXChangeImageViewController.h"
#import "ShoppingModel.h"
#import "ProductModel.h"
#import "ZZProductTempModel.h"
#import "ZZCustomZoneModel.h"

@interface ZZSureMerViewController ()<UITextFieldDelegate,TypeSeleteDelegete,SongColorTypeSeleteDelegete,MerchOrButteDetelagte,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLConnectionDelegate,UIGestureRecognizerDelegate>{
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
    UIView *gestureView;
    
    NSData *_imagedata;
    dispatch_group_t _group;
    
    NSString *_product_id;
    
    CAShapeLayer *border;
    
    //九宫格视图
    UIImageView *contentVi;
    
    BOOL isPerchaseClick;
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

@property (nonatomic, strong) NSMutableArray *colorArray;

@property (nonatomic, strong) ZZProductTempModel *proTempModel;

@property (nonatomic, strong) NSMutableArray *zoneArray;
///生成商品出参
@property (nonatomic, strong) NSArray *productResult;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (nonatomic,strong)CAShapeLayer *border;
@property (nonatomic,assign)float angle;

@property (nonatomic,copy) NSString* print_temp_image;
@end

@implementation ZZSureMerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    ZiseStr = @"";
    ColorStr = @"";
    self.angle = 0;
    isPerchaseClick = NO;
    
    self.NextBtn.layer.cornerRadius = 5.0f;
    self.view.userInteractionEnabled = YES;
    self.choseImageView.userInteractionEnabled = YES;
    self.changeImageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.changeImageBtn.layer.cornerRadius = 3;
    self.changeImageBtn.layer.borderWidth = 1;
    
    self.reductionBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.reductionBtn.layer.cornerRadius = 3;
    self.reductionBtn.layer.borderWidth = 1;

    
    // Do any additional setup after loading the view.
    /**
     这些数据应该从服务器获得 没有服务器我就只能先写死这些数据了
     */
    sizearr = [NSMutableArray arrayWithCapacity:0];
    colorarr  = [NSMutableArray arrayWithCapacity:0];
   
    [self requstSize];
//    [self requstColor];
    
    contentVi = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-165*rateh)/2, (WIDTH-160*rateh)/2, 160*rateh, 240*rateh)];
    contentVi.userInteractionEnabled = YES;
//    contentVi.layer.borderWidth = 1;
//    contentVi.layer.borderColor =[UIColor colorWithHexString:@"148d3f"].CGColor;
    self.border = [CAShapeLayer layer];
    
    //虚线的颜色
    self.border.strokeColor = [UIColor colorWithHexString:@"148d3f"].CGColor;
    //填充的颜色
    self.border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    self.border.path = [UIBezierPath bezierPathWithRect:contentVi.bounds].CGPath;
    
    self.border.frame = contentVi.bounds;
    //虚线的宽度
    self.border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    self.border.lineDashPattern = @[@4, @2];
    
    [contentVi.layer addSublayer:self.border];
    
    
    contentVi.clipsToBounds = YES;
    [self.choseImageView addSubview:contentVi];
    
    self.choseImageView.userInteractionEnabled = YES;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    backView.userInteractionEnabled = YES;

    
   
    MiddImg = [[UIImageView alloc]initWithFrame:CGRectMake((contentVi.bounds.size.width-130*rateh)/2, 100, 130*rateh, 130*rateh)];
    MiddImg.image = _selectImage;
   
    [contentVi addSubview:MiddImg];
    //
    border = [CAShapeLayer layer];
    border.strokeColor = RGBA(107, 188, 99, 1).CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:MiddImg.bounds].CGPath;
    border.frame = CGRectMake((contentVi.bounds.size.width-130*rateh)/2, 20, 130*rateh, 130*rateh);
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    MiddImg.contentMode = UIViewContentModeScaleAspectFit;
    
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    [contentVi addGestureRecognizer:pan];
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [self.choseImageView addGestureRecognizer:pinch];
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    [self.choseImageView addGestureRecognizer:rotation];
    
    //商品信息
    [self getProductDetailInfoWithId:self.temp_id];
    
//    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
//    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
}

//移动手势
-(void)removeTap:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    CGPoint newCenter = CGPointMake(MiddImg.center.x+ translation.x,
                                    MiddImg.center.y + translation.y);//    限制屏幕范围：

    if (CGRectContainsPoint(CGRectMake(CGRectGetWidth(MiddImg.bounds)/2-10,CGRectGetHeight(MiddImg.bounds)/2, CGRectGetWidth(contentVi.bounds)-CGRectGetWidth(MiddImg.bounds)+20, CGRectGetHeight(contentVi.bounds)-CGRectGetHeight(MiddImg.bounds)+10), newCenter)==YES) {
        
        MiddImg.center = newCenter;

        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
    newCenter.y = newCenter.y;
    newCenter.x = newCenter.x;
    
}
-(void)viewWillAppear:(BOOL)animated{
//    [MiddImg.layer addSublayer:border];
}
-(void)viewWillDisappear:(BOOL)animated{
    [border removeFromSuperlayer];

}
//捏合
-(void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    if (scale>=1) {
        if (MiddImg.frame.size.width<10000*rateh) {
            MiddImg.transform = CGAffineTransformScale(MiddImg.transform, scale, scale);
        }
    }else{
        if (MiddImg.frame.size.width>60*rateh) {
            MiddImg.transform = CGAffineTransformScale(MiddImg.transform, scale, scale);
        }
    }
    recognizer.scale = 1.0;
}
//旋转
-(void)handleRotation:(UIRotationGestureRecognizer *)recognizer{
    MiddImg.transform = CGAffineTransformRotate(MiddImg.transform, recognizer.rotation);
    NSLog(@"%lf",recognizer.rotation);
    float degree= recognizer.rotation*(180/M_PI);
    self.angle = self.angle+ degree;
    recognizer.rotation = 0.0;
}

// 请求尺寸和颜色的数据
-(void)requstSize{
    //获取尺寸
    [afnObject POST:API_Producttemplateizes parameters:@{@"product_template_id":self.temp_id} success:^(id responseObject) {
        NSLog(@"size======%@",responseObject);
        NSArray *resultArr = responseObject[@"result"];
        [sizearr addObjectsFromArray:resultArr];
    } failure:^(id error) {
    } Cahche:NO];
}
// 请求颜色的数据
-(void)requstColor{
    
    [afnObject POST:API_ProducTemplateColors parameters:@{@"product_template_id":self.temp_id} success:^(id responseObject) {
        for (NSDictionary *dic in responseObject[@"result"]) {
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
    
    
    choseView.img.text = self.proTempModel.product_temp_name;
    choseView.lb_price.text = [NSString stringWithFormat:@"¥ %@",self.proTempModel.original_price];
    
    
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    
    //颜色分类
    choseView.colorView = [[SongColorView alloc] initWithFrame:CGRectMake(0, 120, choseView.frame.size.width, 50) andDatasource:colorarr :@"分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.height, choseView.frame.size.width, choseView.colorView.height);
    
    
    //购买数量
    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.sizeView.frame.size.height, choseView.frame.size.width, 70);
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
     choseView.lb_price.text = [NSString stringWithFormat:@"¥ %.2f",[self.proTempModel.original_price doubleValue]+50];
}
/**
 *  点击颜色弹出
 */
-(void)SongColorbtnindex:(int)tag{
    ColorStr = colorarr[tag];
    [self.zoneArray removeAllObjects];
    self.proTempModel = self.colorArray[tag];
    self.zoneArray = [ZZCustomZoneModel mj_objectArrayWithKeyValuesArray: self.proTempModel.temp_custom_zones];
    ZZCustomZoneModel *zoneModel = self.zoneArray[0];
    [self.choseImageView sd_setImageWithURL:[NSURL URLWithString:zoneModel.original_image]];
    
    NSLog(@"颜色=========%d",tag);
    
}
/**
 *  点击是购买还是加入购物车
 */
-(void)btnMerchOrButte:(UIButton *)btn{
   UIGraphicsBeginImageContextWithOptions(self.choseImageView.bounds.size, NO, 0.0);
    
    [self.choseImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _imagedata = UIImagePNGRepresentation(viewImage);
    
    
    
    if (![ZiseStr isEqual:@""]&&![ColorStr isEqual:@""]) {
    buyCount = [choseView.countView.tf_count.text intValue]; //选择的数量
        [ZJProgressHUD showProgress];
    if ([btn.titleLabel.text isEqualToString:@"立即购买"]) {
        
        MJWeakSelf
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [weakSelf uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                [weakSelf createProductWithType:NO];
            });
        });

    }else{  // 加入购物车
        
//        contentVi.layer.borderWidth = 1;
        
        MJWeakSelf
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [weakSelf uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                [weakSelf createProductWithType:YES];
            });
        });

     }
    }else{
        [ZJProgressHUD showStatus:@"请选择尺码或颜色" andAutoHideAfterTime:1.3];
    }
}

- (ShoppingModel *)setShoppingModel
{
    ShoppingModel *model = [[ShoppingModel alloc]init];
    model.original_price = self.proTempModel.original_price;
    model.product_temp_name = self.proTempModel.product_temp_name;
    model.product_image = _imageUrl;
    model.quantity = buyCount;
    model.colour_name = ColorStr;
    model.size_name = ZiseStr;
    model.product_id = _product_id;
    
    return model;
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
//    contentVi.layer.borderWidth = 1;
    self.border.lineWidth = 1.f;
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
    
    self.border.lineWidth = 0;
//    UIGraphicsBeginImageContextWithOptions(self.choseImageView.bounds.size, NO, 0.0);
//
//    [self.choseImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    _imagedata = UIImagePNGRepresentation(viewImage);
//    self.border.lineWidth = 1.f;
    [self initChoseView];
    [self btnselete];
    
 }

#pragma mark ------ 接口请求
//生成商品
- (void)createProductWithType:(BOOL)type {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_id"] = USER_ID;
    dic[@"product_templates"] = [self setProductTemplateJsonStr] ;
    dic[@"platform"] = @"ios_phone";
    dic[@"screen_size"] = @"800x600";
    dic[@"app_version"] = @"1.0.0";
    NSLog(@"%@",[self setProductTemplateJsonStr]);
    MJWeakSelf
    [afnObject POST:API_ProductsCreation parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            weakSelf.productResult = responseObject[@"result"];
            //发布商品
            self.print_temp_image = responseObject[@"result"][0][@"product_print_image"];
            [weakSelf creatProductsPublicationWithType:type];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJProgressHUD hideHUD];
            });
            
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
    } Cahche:NO];
    
}
/// API_ProductsCreation 入参
- (NSString *)setProductTemplateJsonStr {
    //v3
    NSMutableDictionary *parameter0 = [NSMutableDictionary dictionary];
    parameter0[@"style_box_h"] = @(600);
    parameter0[@"style_box_w"] = @(450);

    NSMutableDictionary *parameter1 = [NSMutableDictionary dictionary];
    parameter1[@"type"] = @"1";
    parameter1[@"edit_view_level"] = @"0";
    parameter1[@"is_horizontal_filp"] = @"0";
    parameter1[@"is_vertical_filp"] = @"0";
    parameter1[@"image_finnal_size_width"] = @(MiddImg.frame.size.width);
    parameter1[@"image_finnal_size_height"] = @(MiddImg.frame.size.height);
    parameter1[@"image_bg_size_height"] = @(self.choseImageView.frame.size.height);
     parameter1[@"image_bg_size_width"] = @(self.choseImageView.frame.size.width);
    parameter1[@"image_center_point_offset_x"] = @(MiddImg.frame.origin.x+contentVi.frame.origin.x);
    parameter1[@"image_center_point_offset_y"] = @(MiddImg.frame.origin.y+contentVi.frame.origin.y);
    parameter1[@"image_angle"] = [NSString stringWithFormat:@"%@",@(self.angle)];
    parameter1[@"image_type"] = @"1";
    parameter1[@"creative_id"] = self.creative_id;
//    parameter1[@"tag_id"] = self.tagModel.tag_id;
    parameter1[@"tag_id"] = @"47";
//    parameter1[@"series_id"] = self.tagModel.series_id;
    parameter1[@"series_id"] = @"";
    
    NSArray *image_parameters = [NSArray arrayWithObjects:parameter1, nil];
    parameter0[@"image_parameters"] = image_parameters;
    
    NSMutableDictionary *parameter2 = [NSMutableDictionary dictionary];
    parameter2[@"type"] = @"1";
    parameter2[@"image_type"] = @"2";
//    parameter2[@"creative_id"] = self.picModel.source_pic_id;
    parameter2[@"creative_id"] =  self.creative_id;
    
    NSMutableDictionary *parameter3 = [NSMutableDictionary dictionary];
    parameter3[@"type"] = @"2";
    parameter3[@"font_id"] = @"1";
    
    NSArray *origin_parameters = [NSArray arrayWithObjects:parameter2,parameter3, nil];
    parameter0[@"origin_parameters"] = origin_parameters;
    parameter0[@"position_type"] = @"1";
    parameter0[@"craftsmanship_name"] = @"打印";
    parameter0[@"craftsmanship_type"] = @"1";
    
    //v2
    NSArray *creative_parameters = [NSArray arrayWithObjects:parameter0, nil];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"creative_parameters"] = creative_parameters;
    parameter[@"product_temp_id"] = self.temp_id;
    parameter[@"colour_id"] =  self.proTempModel.colour_id;
    parameter[@"design_mode"] = self.design_model;
//    parameter[@"series_id"] = self.tagModel.series_id;
    parameter[@"series_id"] = @"";
    //v1
    NSArray *product_templates = [NSArray arrayWithObjects:parameter, nil];
    
    //数组转json
    NSString *product_templatesStr = [SMGlobalMethod arrayToJson:product_templates];
    NSLog(@"%@",product_templatesStr);
    return product_templatesStr;
}

/**
 发布商品
 */
- (void)creatProductsPublicationWithType:(BOOL)type {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = USER_ID;
    params[@"products"] = [self getPublicationWithJsonStr];
    params[@"platform"] = @"ios_phone";
    NSLog(@"%@",[self getPublicationWithJsonStr]);
    [HWHttpTool post:API_ProductsPublication params:params success:^(id json) {
        [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            _product_id = json[@"result"][@"product_id"];
            self.proTempModel.original_price = json[@"result"][@"data"][0][@"original_price"];
            if (type == NO) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ZJProgressHUD hideHUD];
                    ZZgoumaiViewController *gou = [[ZZgoumaiViewController alloc]init];
                    gou.productModel = [self setShoppingModel];
                    [self.navigationController pushViewController:gou animated:YES];
                });
                
            }else {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"user_id"] = USER_ID;
                dic[@"product_id"] = _product_id;
                dic[@"colour_name"] = ColorStr;
                dic[@"size_name"] = ZiseStr;
                dic[@"quantity"] = @(buyCount);
                MJWeakSelf
                NSLog(@"%@",dic);
                [afnObject POST:API_AddShoppingCar parameters:dic success:^(id responseObject) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [ZJProgressHUD hideHUD];
                    });
                    if([responseObject[@"state"] isEqualToString:@"M00000"]) {
                        [weakSelf dismiss];
                        
                        [ZJProgressHUD showStatus:@"添加成功" andAutoHideAfterTime:1.1];
                    }else
                    {
                        [ZJProgressHUD showStatus:responseObject[@"message"] andAutoHideAfterTime:1.1];
                    }
                    
                } failure:^(id error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [ZJProgressHUD hideHUD];
                    });
                } Cahche:NO];
                
            }
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJProgressHUD hideHUD];
            });
            [ZJProgressHUD showStatus:json[@"massage"] andAutoHideAfterTime:1.1];
        }
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
    }];
    
}
///发布商品入参
- (NSString *)getPublicationWithJsonStr {
    /**
     [{"product_print_detail":[{"product_print_id":"2726","original_image":"/images\/201801\/50ae9a4c1643251bb17d26bd675ac4a0.jpg","thumbnail":"/images\/201801\/baff20a138a670df603a06c208039431.jpg"}],"colour_id":"2","product_temp_id":"2017101652545456"}]
     */
    NSArray *product_print_detail = self.productResult[0][@"product_print_detail"];
    NSString *colour_id = self.proTempModel.colour_id;
    NSString *product_temp_id = self.temp_id;
    
    NSDictionary *dic = @{@"product_print_detail":product_print_detail,@"colour_id":colour_id,@"product_temp_id":product_temp_id,@"product_print_image":self.print_temp_image};
    
    NSArray *par = [NSArray arrayWithObjects:dic, nil];
    //数组转json
    NSString *parStr = [SMGlobalMethod arrayToJson:par];
    NSLog(@"%@",parStr);
    return parStr;
}


- (void)uploadToImage {
    dispatch_group_enter(_group);
    [HWHttpTool post:API_ImageUpload params:@{@"height":@"100",@"width":@"100"} fileDatas:@[_imagedata] name:@"image" fileNames:@[@"finished.png"] mimeTypes:@[@"image/png"] success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"result"][@"original_imag_url"]];
            _imageUrl = imageUrl;
        }

        dispatch_group_leave(_group);
    } failure:^(NSError *error) {
        dispatch_group_leave(_group);
        NSLog(@"%@",error);
    }];
}


- (void)getProductDetailInfoWithId:(NSString *)product_tempId {
    [ZJProgressHUD showProgress];
    [HWHttpTool post:API_ProductsTempInfo params:@{@"product_temp_id":product_tempId,@"colour_id":@"1"} success:^(id json) {
        [ZJProgressHUD hideHUD];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([json[@"state"] isEqualToString:@"M00000"]) {
                self.colorArray = [ZZProductTempModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"temp_colours"]];
                self.proTempModel = self.colorArray[0];
                self.zoneArray = [ZZCustomZoneModel mj_objectArrayWithKeyValuesArray:self.proTempModel.temp_custom_zones];
                for (ZZProductTempModel *colorModel in self.colorArray) {
                    [colorarr addObject:colorModel.colour_name];
                }
                
                ZZCustomZoneModel *zoneModel = self.zoneArray[0];
//                [self.choseImageView sd_setImageWithURL:[NSURL URLWithString:zoneModel.original_image]];
                [self.choseImageView sd_setImageWithURL:[NSURL URLWithString:self.thumbnail1]];
                
            }
        });
        
    } failure:^(NSError *error) {
        [ZJProgressHUD hideHUD];
    }];
}


#pragma mark ---- 懒加载

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (NSMutableArray *)zoneArray {
    if (!_zoneArray) {
        _zoneArray = [NSMutableArray array];
    }
    return _zoneArray;
}




- (IBAction)clickChangeImage:(UIButton *)sender {
    
    XXChangeImageViewController *changImageVC = initVCFromSTBWithIdentifer(@"DrawingStoryboard", @"XXChangeImageViewController");
    changImageVC.imageBlock = ^(UIImage *image) {
        [MiddImg setImage:image];
    };
    [self.navigationController pushViewController:changImageVC animated:YES];
}

- (IBAction)clickReductionBtn:(UIButton *)sender {
    [MiddImg setImage:self.selectImage];
}






@end

