//
//  ViewController.m
//  FaceImage
//
//  Created by 徐征 on 2017/10/25.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "ViewController.h"
#import "FCDetectViewController.h"
#import "WorkViewController.h"
#import "SelectedImageViewController.h"
//#import "XXFaceBeautify.h"
#import "XPSFaceBeautify.h"
#import "CameraViewController.h"
#import "DrawingViewController.h"
#import "SelectCollectionCell.h"

static const double scaling = 1.191;

static const double haiXPercnet = 153.897/314/scaling;
static const double haiYPercnet = (94.990-64)/377/scaling;
static const double haiWPercent = 64.915/314/scaling;
static const double haiHPercent = 76.135/377/scaling;

static const double faceXPercnet = (157.360+1)/314/scaling;
static const double faceYPercnet = (142.010-64 -15)/377/scaling;
static const double faceWPercent = 56.465/314/scaling;
static const double faceHPercent = (60.522+17+8)/377/scaling;

static const double faceStyleXPercnet = 153.597/314/scaling;
static const double faceStyleYPercnet = (112.528-64)/377/scaling;
static const double faceStyleWPercent = 66.805/314/scaling;
static const double faceStyleHPercent = 84.642/377/scaling;


@interface ViewController ()<XMFSegmentViewDataSource, XMFSegmentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL _isPan;
    NSInteger _tapTag;
    BOOL _isData; //是否有数据
    BOOL _isFace; //是否已经识别面部
    
    double _xpercent;
    double _yPercent;
    double _wPercent;
    double _hPercent;
    NSInteger _seleModle;
    NSInteger _seleStyle;
    NSInteger _step;  //步骤
    
    CGFloat _bHeight;
    CGFloat _bWidth;
    
    
    
    
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *stepsArray;

@property (weak, nonatomic) IBOutlet UIButton *setpBtn;

@property (nonatomic , strong)UITapGestureRecognizer *tapGesture;
@property (nonatomic , assign)BOOL isHidden;

@property (nonatomic, strong) UITapGestureRecognizer *hairTapGes;
@property (nonatomic, strong) UITapGestureRecognizer *faceStyleTapGes;
@property (nonatomic, strong) UITapGestureRecognizer *faceTapGes;


@property (strong, nonatomic) UIImageView *faceImageView;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic, strong)UIView *rectView;

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong) UIButton *smallImageBtn;

@property (strong, nonatomic) UIImageView *imageView_big;

@property (weak, nonatomic) IBOutlet UIView *chose_view;

@property (nonatomic, strong) XMFSegmentView *segmentView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableArray *imageArrayFromBmob;

@property (nonatomic, strong) NSMutableArray *imageUrlArrayFromBmob;

@property (nonatomic, strong) NSMutableArray *titleAry;

@property (nonatomic, strong) NSMutableArray *collectionTitleAry;


@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation ViewController

- (UIImageView *)imageView_big
{
    if (!_imageView_big) {
        CGFloat bHeight = SCREEN_HEIGHT - 64-40-60-110-16;   // /449.64
        CGFloat bWidth = bHeight * 0.834; // /375  scaling
        _imageView_big = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bWidth, bHeight)];
    }
    return _imageView_big;
}
-(NSMutableArray *)titleAry{
    if (!_titleAry) {
        _titleAry = [NSMutableArray array];
    }
    return _titleAry;
}

-(NSMutableArray *)collectionTitleAry{
    if (!_collectionTitleAry) {
        _collectionTitleAry = [NSMutableArray array];
    }
    return _collectionTitleAry;
}

-(NSMutableArray *)imageArrayFromBmob{
    if (!_imageArrayFromBmob) {
        _imageArrayFromBmob = [NSMutableArray array];
    }
    return _imageArrayFromBmob;
}
-(NSMutableArray *)imageUrlArrayFromBmob{
    if (!_imageUrlArrayFromBmob) {
        _imageUrlArrayFromBmob = [NSMutableArray array];
    }
    return _imageUrlArrayFromBmob;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    
    //TODO: bom
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    
//    MJWeakSelf
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
//    //查找GameScore表的数据
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//
//        if (error == nil) {
//            [weakSelf.imageArrayFromBmob removeAllObjects];
//            [weakSelf.imageUrlArrayFromBmob removeAllObjects];
//            for (BmobObject *obj in array) {
//                //打印playerName
//                NSLog(@"obj.playerName = %@", [obj objectForKey:@"image"]);
//                //打印objectId,createdAt,updatedAt
//                NSLog(@"obj.objectId = %@", [obj objectId]);
//                NSLog(@"obj.createdAt = %@", [obj createdAt]);
//                NSLog(@"obj.updatedAt = %@", [obj updatedAt]);
//
//                [weakSelf.imageArrayFromBmob addObject:[obj objectId]];
//
//                NSDictionary *dic = [obj objectForKey:@"image"];
//                NSString *imageUrl = [dic valueForKey:@"url"];
//                [weakSelf.imageUrlArrayFromBmob addObject:imageUrl];
//                [weakSelf.collectionView reloadData];
//                [weakSelf updateCollectionWithSele];
//
//
//
//
//            }
//            [weakSelf networkRequestDataWithObjectId:self.imageArrayFromBmob[0]];
//
//        }
//
//    }];
//
//    NSDictionary *paramDic =@{@"objectId":@"19bb3136d9"};
//    [HWHttpTool post:@"http://www.nicway.cn/api/v2/facloud/fproduct" params:paramDic success:^(id json) {
//
//    } failure:^(NSError *error) {
//
//    }] ;
//
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bHeight = SCREEN_HEIGHT - 64-40-60-110-16;
    _bWidth = _bHeight*0.834;
    self.title = @"";
    
    
    MJWeakSelf;
    [HWHttpTool post:@"http://www.nicway.cn/api/v2/facloud/list" params:nil success:^(id json) {
        if ([json[@"message"] isEqualToString:@"成功"]) {
            NSArray *ary = json[@"data"][@"results"];
            weakSelf.titleAry = [NSMutableArray arrayWithArray:ary];
            
            for (NSDictionary *dic in ary) {
                [weakSelf.collectionTitleAry addObject:[NSString stringWithFormat:@"%@",dic[@"title"]]];
                
            }
            [weakSelf setcor_view];
            [weakSelf.collectionView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    _tapTag = 0;
    _isData = NO;
    _seleModle = 1;
    _seleStyle = 0;
    _step = 0;
    [self.setpBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    
    //    self.imageView_big.image = [UIImage imageNamed:@"2男蝙蝠2.jpg"];
    self.imageView_big.image = [UIImage imageNamed:@"2军人男2.jpg"];
    
    self.faceImageView.backgroundColor = [UIColor whiteColor];
    //    self.faceImageView.contentMode = UIViewContentModeScaleAspectFill;
    CGFloat bHeight = SCREEN_HEIGHT - 64-40-60-110-16;
    CGFloat bWidth = bHeight * 0.834;
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(112);
        make.width.mas_equalTo(bWidth);
        make.height.mas_equalTo(bHeight);
        
    }];
    
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewRotationAction:)];
    rotationGes.delegate = self;
    //    [backGroundView addGestureRecognizer:rotationGes];
    
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPinchAction:)];
    pinchGes.delegate =self;
    //    [backGroundView addGestureRecognizer:pinchGes];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPanAction:)];
    [panGes setMinimumNumberOfTouches:1];
    [panGes setMaximumNumberOfTouches:1];
    panGes.delegate = self;
    //    [backGroundView addGestureRecognizer:panGes];
    
    self.backGroundView = backGroundView;
    
    //    [self.view addSubview:backGroundView];
    [self.view insertSubview:backGroundView atIndex:0];
    
    [self.backGroundView addSubview:self.imageView_big];
    self.faceStyleImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"男1"]];
    self.faceStyleImageV.frame = CGRectMake(_bWidth * faceStyleXPercnet, _bHeight * faceStyleYPercnet, _bWidth * faceStyleWPercent, _bHeight * faceStyleHPercent);
    self.faceStyleImageV.tag = 101;
    self.faceStyleImageV.userInteractionEnabled = YES;
    self.faceStyleImageV.layer.borderWidth = 1;
    self.faceStyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
    [self.backGroundView addSubview:self.faceStyleImageV];
    self.faceStyleTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    self.faceStyleTapGes.delegate = self;
    //    [self.faceStyleImageV addGestureRecognizer:self.faceStyleTapGes];
    
    self.hairstyleImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"发型20男"]];
    self.hairstyleImageV.frame = CGRectMake(_bWidth * haiXPercnet, _bHeight * haiYPercnet, _bWidth * haiWPercent, _bHeight *haiHPercent);
    self.hairstyleImageV.tag = 102;
    self.hairstyleImageV.userInteractionEnabled = YES;
    self.hairstyleImageV.layer.borderWidth = 1;
    self.hairstyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
    [self.backGroundView addSubview:self.hairstyleImageV];
    
    self.hairTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    self.hairTapGes.delegate = self;
    //    [self.hairstyleImageV addGestureRecognizer:self.hairTapGes];
    
    self.faceTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    self.faceTapGes.delegate = self;
    [self updateCollectionWithSele];
    
    
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    _tapGesture.delegate = self;
    
    //    [self.backGroundView addGestureRecognizer:_tapGesture];
    
    for (UIButton *btn in self.stepsArray) {
        if (btn.tag == 50) {
            btn.backgroundColor = YEllOWColor;
        }
    }
    
    self.faceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_bWidth *faceXPercnet+3, _bHeight *faceYPercnet-4, _bWidth * faceWPercent-4, faceHPercent *_bHeight-8)];
    [self.backGroundView addSubview:self.faceImageView];
    self.faceImageView.image = [UIImage imageNamed:@"军人2-"];
    self.faceImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
    //    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
}


- (void)clickLeftItemA {
    if (self.secondStep) {
        [self cancelStep];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)tapAction:(UIGestureRecognizer *)gesture{
}


- (IBAction)startOrNest:(UIButton *)sender {
    
    if (_step == 0) {
        [self addImage];
        
    }else {
        //        ZZxchoseViewController *xue = [[ZZxchoseViewController alloc]init];
        //        [self.navigationController pushViewController:xue animated:YES];
        
        DrawingViewController *drae = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"DrawingViewController"]; ;
        drae.image_mat = self.imageView_big.image;
        drae.image_face = self.faceImageView.image;
        drae.image_hair = self.hairstyleImageV.image;
        drae.image_facestyle = self.faceStyleImageV.image;
        
        drae.rect_face = self.faceImageView.frame;
        drae.rect_hair = self.hairstyleImageV.frame;
        drae.rect_facestyle = self.faceStyleImageV.frame;
        
        [self.navigationController pushViewController:drae animated:YES];
    }
}

- (void)cancelStep {
    
    _step = 0;
    self.faceImageView.image = [UIImage imageNamed:@"军人2-"];
    _seleModle = 1;
    _isFace = NO;
    NSArray *haistyletitleArray = @[@"经典"];
    self.segmentView.titleArray = [NSMutableArray arrayWithArray:haistyletitleArray];
    
    [self updateCollectionWithSele];
    self.secondStep = NO;
    
    
}

- (void)addImage {
    CameraViewController *cameraVC = [[CameraViewController alloc]init];
    cameraVC.image_mat = self.imageView_big.image;
    cameraVC.image_hair = self.hairstyleImageV.image;
    cameraVC.image_facestyle = self.faceStyleImageV.image;
    
    cameraVC.rect_face = self.faceImageView.frame;
    cameraVC.rect_hair = self.hairstyleImageV.frame;
    cameraVC.rect_facestyle = self.faceStyleImageV.frame;
    //    __weak typeof(self) weakSelf = self;
    
    //    cameraVC.imageblock = ^(UIImage *image) {
    //        if (image != nil) {
    //            if (weakSelf.faceImageView) {
    //                weakSelf.faceImageView.image = nil;
    //            }
    //
    //            weakSelf.faceImageView.tintColor = [UIColor whiteColor];
    //
    ////            UIImage *  img = [XPSFaceBeautify imageToFaceHandleImage:image isTransparent:YES];
    //            [weakSelf.faceImageView setImage:image];
    //
    //            weakSelf.faceImageView.tag = 103;
    //            weakSelf.faceImageView.alpha = 0.5;
    //
    //            weakSelf.hairstyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
    //
    ////            [weakSelf.faceImageView addGestureRecognizer:self.faceTapGes];
    //
    //            _tapTag = weakSelf.faceImageView.tag;
    //            weakSelf.faceImageView.userInteractionEnabled = YES;
    //            weakSelf.hairstyleImageV.userInteractionEnabled = YES;
    //            [weakSelf.backGroundView bringSubviewToFront:self.hairstyleImageV];
    //            _step = 1;
    //            weakSelf.secondStep = YES;
    //
    //            _seleModle = 2;
    //            _isFace = YES;
    //
    //            NSArray *haistyletitleArray = @[@"发型",@"脸型"];
    //            self.segmentView.titleArray = [NSMutableArray arrayWithArray:haistyletitleArray];
    //            [self updateCollectionWithSele];
    //        }else
    //        {
    //            NSLog(@"图片处理失败！");
    //            _step = 0;
    //            weakSelf.secondStep = NO;
    //        };
    //    };
    
    [self.navigationController pushViewController:cameraVC animated:YES];
}

#pragma mark 手势触发事件
-(void)backGroundViewPinchAction:(UIPinchGestureRecognizer *)gesture{
    if (_tapTag != 0) {
        UIView *view = [self.view viewWithTag:_tapTag];
        
        if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
            
            view.transform = CGAffineTransformScale(view.transform, gesture.scale, gesture.scale);
            gesture.scale = 1;
        }
    }
    
}
-(void)backGroundViewPanAction:(UIPanGestureRecognizer *)gesture{
    if (_tapTag != 0) {
        UIView *view = [self.view viewWithTag:_tapTag];
        
        if (gesture.numberOfTouches == 1) {
            if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
                CGPoint transLation = [gesture translationInView:self.backGroundView];
                view.center = CGPointMake(view.center.x + transLation.x, view.center.y + transLation.y);
                [gesture setTranslation:CGPointZero inView:self.backGroundView];
            }
        }
    }
    
}

-(void)backGroundViewRotationAction:(UIRotationGestureRecognizer *)gesture{
    if (_tapTag != 0) {
        UIView *view = [self.view viewWithTag:_tapTag];
        
        view.transform = CGAffineTransformRotate(view.transform, gesture.rotation);
        
        gesture.rotation = 0;
    }
}

-(void)tapImageAction:(UITapGestureRecognizer *)gesture {
    if (gesture.view.tag == _tapTag) {
        _tapTag = 0;
        self.hairstyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
        self.faceImageView.layer.borderColor = [UIColor clearColor].CGColor;
        self.faceStyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
    }else
    {
        _tapTag = gesture.view.tag;
        
        if (_tapTag == 101) {
            self.hairstyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
            self.faceImageView.layer.borderColor = [UIColor clearColor].CGColor;
            self.faceStyleImageV.layer.borderColor = [UIColor greenColor].CGColor;
            
        }else if (_tapTag == 102) {
            self.hairstyleImageV.layer.borderColor = [UIColor greenColor].CGColor;
            self.faceImageView.layer.borderColor = [UIColor clearColor].CGColor;
            self.faceStyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
            
        }else if (_tapTag == 103) {
            self.hairstyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
            self.faceImageView.layer.borderColor = [UIColor greenColor].CGColor;
            self.faceStyleImageV.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        return YES;
    }else if ([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        return YES;
    }else
    {
        return NO;
    }
}


#pragma mark ---- RequestData

- (void)networkRequestDataWithObjectId:(NSString *)objectId {
    [ZJProgressHUD showProgress];
    __weak typeof(self) weakSelf = self;
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    
    [bquery getObjectInBackgroundWithId:objectId block:^(BmobObject *object,NSError *error){
        
        if (error){
            //进行错误处理
            [ZJProgressHUD hideHUD];
            NSLog(@"%@",error);
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                
                /*
                 "coord_x" = "3540/7100";
                 "coord_y" = "2165/7092";
                 createdAt = "2017-10-28 09:56:40";
                 height = 414;
                 image =     {
                 "__type" = File;
                 cdn = upyun;
                 filename = "\U519b\U4eba\U75372.jpg";
                 url = "http://bmob-cdn-14765.b0.upaiyun.com/2017/10/28/7c2dadd640678ddb80b5ffa8a734de56.jpg";
                 };
                 objectId = 8eXB4446;
                 updatedAt = "2017-10-28 15:07:58";
                 username = "\U519b\U4eba\U75372";
                 width = 414;
                 
                 hai_x
                 hai_y
                 hai_w
                 hai_h
                 
                 */
                //脸
                NSString *coordx = [object objectForKey:@"coord_x"];
                double xpercent = ([coordx doubleValue]+1.2) / 314;
                _xpercent = xpercent;
                
                NSString *coordy = [object objectForKey:@"coord_y"];
                double yPercent = ([coordy doubleValue]-64-20) / 377;
                _yPercent = yPercent;
                
                NSString *width = [object objectForKey:@"width"];
                double wPercent = [width doubleValue] / 314;
                _wPercent = wPercent;
                NSString *height = [object objectForKey:@"height"];
                double hPercent = ([height doubleValue] +17)/ 377;
                _hPercent = hPercent;
                
                CGFloat fx = _bWidth * xpercent;
                CGFloat fy = _bHeight * yPercent;
                CGFloat fw = _bWidth * wPercent;
                CGFloat fh = _bHeight * hPercent;
                
                //头发
                NSString *haix = [object objectForKey:@"hai_x"];
                double haixp = [haix doubleValue] / 314;
                
                NSString *haiy = [object objectForKey:@"hai_y"];
                double haiyp = ([haiy doubleValue]-64) / 377;
                
                NSString *haiw = [object objectForKey:@"hai_w"];
                double haiwp = [haiw doubleValue] / 314;
                
                NSString *haih = [object objectForKey:@"hai_h"];
                double haihp = [haih doubleValue] / 377;
                
                CGFloat hx = (_bWidth * haixp)/scaling; //0.4221
                CGFloat hy = _bHeight * haiyp/scaling; //0.1853
                CGFloat hw = _bWidth * haiwp/scaling; //0.1976
                CGFloat hh = _bHeight * haihp/scaling; //0.1303
                
                //脸型
                NSString *faceStyle_x = [object objectForKey:@"faceStyle_x"];
                double faceStyle_xp = [faceStyle_x doubleValue] / 314;
                
                NSString *faceStyle_y = [object objectForKey:@"faceStyle_y"];
                double faceStyle_yp = ([faceStyle_y doubleValue]-64) / 377;
                
                NSString *faceStyle_w = [object objectForKey:@"faceStyle_w"];
                double faceStyle_wp = [faceStyle_w doubleValue] / 314;
                
                NSString *faceStyle_h = [object objectForKey:@"faceStyle_h"];
                double faceStyle_hp = [faceStyle_h doubleValue] / 377;
                
                CGFloat fsx = _bWidth * faceStyle_xp/scaling;
                CGFloat fsy = _bHeight * faceStyle_yp/scaling;
                CGFloat fsw = _bWidth * faceStyle_wp/scaling;
                CGFloat fsh = _bHeight * faceStyle_hp/scaling;
                
                NSDictionary *imageDic = (NSDictionary *)[object objectForKey:@"image"];
                NSString *imageUrl = [imageDic valueForKey:@"url"];
                SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
                
                [manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderIgnoreCachedResponse progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data == nil) {
                            
                            weakSelf.imageView_big.image = [UIImage imageNamed:@"2男蝙蝠2.jpg"];
                            [ZJProgressHUD hideHUD];
                            
                        }else
                        {
                            weakSelf.imageView_big.image = [UIImage imageWithData:data];
                            weakSelf.hairstyleImageV.frame = CGRectMake(hx, hy, hw, hh);
                            weakSelf.faceStyleImageV.frame = CGRectMake(fsx, fsy, fsw, fsh);
                            if (weakSelf.faceImageView) {
                                weakSelf.faceImageView.frame = CGRectMake(fx/scaling+2, fy/scaling, fw/scaling-4, fh/scaling);
                                [ZJProgressHUD hideHUD];
                            }
                            [ZJProgressHUD hideHUD];
                            _isData = YES;
                        }
                    });
                }];
                
                NSLog(@"%ld",(long)coordx);
                
            }
        }
    }];
}


-(void)setcor_view{
    XMFSegmentView *view_sco = [[XMFSegmentView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 35)];
    _chose_view.backgroundColor = [UIColor whiteColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 0;
    self.segmentView = view_sco;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SelectCollectionCell"];

    [_chose_view addSubview: self.segmentView];
    [_chose_view addSubview:self.collectionView];
   
}

// / 标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
//    NSArray *ary = @[@"经典"];
//    NSMutableArray *collectionTitleAry = [NSMutableArray array];
//
//    for (NSDictionary *dic in self.titleAry) {
//        [collectionTitleAry addObject:[NSString stringWithFormat:@"%@",dic[@"title"]]];
//    }
    NSString *str;
    if (self.collectionTitleAry.count > 0) {
       str = self.collectionTitleAry[index];

    }else{
        str = @"经典";
    }
    return str;
}

//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
    
    return 80.0f;
}

//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {
    if (self.titleAry.count > 0) {
        return self.titleAry.count;
        
    }else{
        return 1;
    }
}

//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    NSLog(@"点击了%ld", index);
    MJWeakSelf;
    _seleStyle = index;
    
    _seleModle = _isFace ? index + 2 : 1;
    
    NSDictionary *sourceDic = self.titleAry[index];
    NSDictionary *paramDic =@{@"objectId":[NSString stringWithFormat:@"%@",sourceDic[@"objectId"]]};
    [HWHttpTool post:@"http://www.nicway.cn/api/v2/facloud/fproduct" params:paramDic success:^(id json) {
        if ([json[@"message"]isEqualToString:@"成功"]) {
            [weakSelf.imageArrayFromBmob removeAllObjects];
            [weakSelf.imageUrlArrayFromBmob removeAllObjects];
            NSArray *imgDataAry = json[@"data"][@"results"];
            for (NSDictionary *daDic in imgDataAry) {
                
                [weakSelf.imageArrayFromBmob addObject:daDic[@"objectId"]];
                [weakSelf.imageUrlArrayFromBmob addObject:daDic[@"image"][@"url"]];
               
            }
            [weakSelf updateCollectionWithSele];
            [weakSelf.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }] ;
    
    [self updateCollectionWithSele];
}

//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor blackColor];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nibBundleOrNil];
        ViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"allViewZ"];
        self = message;
    }
    return  self;
}

#pragma mark --
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        NSArray  *imageArray1 = @[@"2男蝙蝠2.jpg",@"2男蝙蝠.jpg"];
        _imageArray = [NSMutableArray arrayWithArray:imageArray1];
    }
    return _imageArray;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.itemSize = CGSizeMake(65, 65);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 37, SCR_WIDTH-20, 70) collectionViewLayout:layout];
        _collectionView.layer.cornerRadius = 4;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)self.imageArrayFromBmob.count);
    return self.imageArrayFromBmob.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCollectionCell" forIndexPath:indexPath];
    
    for (SelectCollectionCell *cell in collectionView.visibleCells) {
        cell.contentView.layer.cornerRadius = 2;
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        
    }
    if (indexPath.row == 0) {
        cell.contentView.layer.cornerRadius = 2;
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = YEllOWColor.CGColor;
    }
    NSLog(@"%@",self.imageUrlArrayFromBmob[indexPath.row]);
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArrayFromBmob[indexPath.row]]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArrayFromBmob[indexPath.row]] placeholderImage:[UIImage imageNamed:@"url_placehold_image.png"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_seleModle == 1) {
        
        
        if (_seleStyle == 0) {
            NSArray *objcArray = self.imageArrayFromBmob;
            [self networkRequestDataWithObjectId:objcArray[indexPath.row]];
        }else if (_seleStyle == 1) {
            NSArray *objcArray = self.imageArrayFromBmob;
            [self networkRequestDataWithObjectId:objcArray[indexPath.row]];
        }
        
        
    }else if (_seleModle == 2) {
        NSArray  *imageArray2 = @[@"发型20男",@"发型10男孩",@"发型19男",@"发型18男",@"发型11男孩"];
        [self.hairstyleImageV setImage:[UIImage imageNamed:imageArray2[indexPath.row]]];
    }else if (_seleModle == 3){
        NSArray  *imageArray3 = @[@"男1",@"男2",@"男3",@"男4",@"男5"];
        [self.faceStyleImageV setImage:[UIImage imageNamed:imageArray3[indexPath.row]]];
    }
    
    for (SelectCollectionCell *cell in collectionView.visibleCells) {
        cell.contentView.layer.cornerRadius = 2;
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = RGBA(255, 255, 255, 1).CGColor;
    }
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.cornerRadius = 2;
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.borderColor = YEllOWColor.CGColor;
}



//更新
- (void)updateCollectionWithSele
{
    NSArray  *imageArray1 = @[@"2男蝙蝠2.jpg",@"2男蝙蝠.jpg"];
    NSArray *imageArr = @[@"2军人男2.jpg",@"2男超人.jpg",@"2军人小孩1.jpg"];
    NSArray  *imageArray2 = @[@"发型20男",@"发型10男孩",@"发型19男",@"发型18男",@"发型11男孩"];
    NSArray  *imageArray3 = @[@"男1",@"男2",@"男3",@"男4",@"男5"];
    
   
    
    [self.imageArray removeAllObjects];
    if (_seleModle == 1) {
        
        if (_seleStyle == 0) {
            [self.imageArray addObjectsFromArray:self.imageUrlArrayFromBmob];
        }else if (_seleStyle == 1)
        {
            [self.imageArray addObjectsFromArray:self.imageUrlArrayFromBmob];
        }
        
        
        
        for (UIButton *btn in self.stepsArray) {
            if (btn.tag == 50) {
                btn.backgroundColor = YEllOWColor;
                btn.selected = YES;
            }else
            {
                btn.backgroundColor = RGBA(235, 235, 235, 1);
                btn.selected = NO;
            }
        }
        
    }else {
        
        for (UIButton *btn in self.stepsArray) {
            if (btn.tag == 51) {
                btn.backgroundColor = YEllOWColor;
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
                btn.backgroundColor = RGBA(235, 235, 235, 1);
            }
            
        }
        
        if (_seleModle == 2) {
            [self.imageArray addObjectsFromArray:imageArray2];
        }else if (_seleModle == 3) {
            [self.imageArray addObjectsFromArray:imageArray3];
        }
    }
    
    [self.collectionView reloadData];
    
}

@end

