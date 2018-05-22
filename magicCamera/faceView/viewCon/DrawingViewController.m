//
//  DrawingViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/8.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "DrawingViewController.h"
#import "SelectCollectionCell.h"
#import "CameraViewController.h"
#import "XPSFaceBeautify.h"
#import "ZZCreatViewController.h"
#import "ZZChooseViewController.h"
#import "ZZMerchandiseViewController.h"

#define bHeight  SCR_HEIGHT - 64-40-60-110-16
#define bWidth  (SCR_HEIGHT - 64-40-60-110-16) * 0.834

@interface DrawingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XMFSegmentViewDelegate,XMFSegmentViewDataSource>
{
    NSInteger _seleStyle;
    UIImage *_sourceImage;//素材图片
    NSString *_imageUrl; //图片地址
    NSString *_thumbnailStr;// 缩略图地址
    NSData *_imagedata;
    dispatch_group_t _group;
}

@property (weak, nonatomic) IBOutlet UIView *chose_view;
@property (nonatomic, strong) UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;

@property (strong, nonatomic) UIImageView *imageView_big;
@property (weak, nonatomic) IBOutlet UIButton *setpBtn;
@property (nonatomic, strong) UIButton *tapFaceBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *btmCollectionView;
@property (nonatomic, strong) UIImageView *faceImageView;
@property (nonatomic, strong) UIImageView *faceStyleImageView;
@property (nonatomic, strong) UIImageView *hairImageView;

@property (nonatomic, strong) NSMutableArray *faceArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
//@property (nonatomic , strong)UITapGestureRecognizer *tapGesture;
@property (nonatomic , assign)BOOL isHidden;
@property (nonatomic, strong) XMFSegmentView *segmentView;

@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation DrawingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    
    self.imageView_big.image = self.image_mat;
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(112);
        make.width.mas_equalTo(bWidth);
        make.height.mas_equalTo(bHeight);
    }];
    [self.view insertSubview:self.backgroundView atIndex:0];
    
    [self.backgroundView addSubview:self.imageView_big];
    [self.backgroundView addSubview:self.faceStyleImageView];
    [self.backgroundView addSubview:self.hairImageView];
    [self.backgroundView addSubview:self.faceImageView];
    [self.backgroundView addSubview:self.tapFaceBtn];
    [self.backgroundView addSubview:self.collectionView];
    [self.backgroundView bringSubviewToFront:self.hairImageView];
    [self.backgroundView bringSubviewToFront:self.tapFaceBtn];

    self.collectionView.hidden = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SelectCollectionCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view sendSubviewToBack:self.backImageV];
    [self setcor_view];
    
    
    //    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
    //    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
}

- (void)clickLeftItemA {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setcor_view{
    XMFSegmentView *view_sco = [[XMFSegmentView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 35)];
    _chose_view.backgroundColor = [UIColor whiteColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 0;
    self.segmentView = view_sco;
    [_chose_view addSubview: self.segmentView];
    
    [self.btmCollectionView registerNib:[UINib nibWithNibName:@"SelectCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SelectCollectionCell"];
    [_chose_view addSubview:self.btmCollectionView];
    
}
// / 标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
    NSArray *ary = @[@"发型",@"脸型"];
    NSString *str = ary[index];
    return str;
}
//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
    return 80.0f;
}
//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {
    return 2;
}
//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    NSLog(@"点击了%ld", index);
    _seleStyle = index;
    [self updateCollectionWithSele];
}
//更新
- (void)updateCollectionWithSele
{
    NSArray  *imageArray2 = @[@"发型20男",@"发型10男孩",@"发型19男",@"发型18男",@"发型11男孩"];
    NSArray  *imageArray3 = @[@"男1",@"男2",@"男3",@"男4",@"男5"];
    [self.imageArray removeAllObjects];
    if (_seleStyle == 0) {
        [self.imageArray addObjectsFromArray:imageArray2];
    }else if (_seleStyle == 1) {
        [self.imageArray addObjectsFromArray:imageArray3];
    }
    [self.btmCollectionView reloadData];
}

//  高亮的颜色
- (UIColor *)highlightColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor grayColor];
}
//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor blackColor];
}
#pragma mark --- lazy

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        NSArray  *imageArray1 = @[@"发型20男",@"发型10男孩",@"发型19男",@"发型18男",@"发型11男孩"];
        _imageArray = [NSMutableArray arrayWithArray:imageArray1];
    }
    return _imageArray;
}

- (NSMutableArray *)faceArray
{
    if (!_faceArray) {
        _faceArray = [NSMutableArray arrayWithObjects:@"组-3",@"军人",@"军人2",@"超人", nil];
    }
    return _faceArray;
}

- (UIImageView *)imageView_big
{
    if (!_imageView_big) {
        _imageView_big = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bWidth, bHeight)];
    }
    return _imageView_big;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blueColor];
        
        UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewRotationAction:)];
        rotationGes.delegate = self;
        [_backgroundView addGestureRecognizer:rotationGes];
        
        UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPinchAction:)];
        pinchGes.delegate =self;
        [_backgroundView addGestureRecognizer:pinchGes];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPanAction:)];
        [panGes setMinimumNumberOfTouches:1];
        [panGes setMaximumNumberOfTouches:1];
        panGes.delegate = self;
//        [_backgroundView addGestureRecognizer:panGes];
    }
    return _backgroundView;
}

- (UICollectionView *)btmCollectionView
{
    if (!_btmCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.itemSize = CGSizeMake(65, 65);
        _btmCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 37, SCR_WIDTH, 70) collectionViewLayout:layout];
        _btmCollectionView.layer.cornerRadius = 4;
        _btmCollectionView.backgroundColor = [UIColor whiteColor];
        _btmCollectionView.showsHorizontalScrollIndicator = NO;
        _btmCollectionView.dataSource = self;
        _btmCollectionView.delegate = self;
        _btmCollectionView.tag = 5;
    }
    return _btmCollectionView;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 10; //水平方向间距
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake(55, 55);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(-10, self.rect_face.origin.y + self.rect_face.size.height + 50, bWidth+20, 70) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        _collectionView.layer.cornerRadius = 4;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.tag = 4;
    }
    return _collectionView;
}

- (UIButton *)tapFaceBtn
{
    if (!_tapFaceBtn) {
        _tapFaceBtn = [[UIButton alloc]init];
        //        _tapFaceBtn.frame = CGRectMake(SCR_WIDTH/2-80, 150, 80, 80);
        CGFloat x = self.rect_facestyle.origin.x + 10;
        CGFloat y = self.rect_facestyle.origin.y + 14;
        CGFloat w = self.rect_facestyle.size.width - 20;
        CGFloat h = self.rect_facestyle.size.height - 22;
        
        _tapFaceBtn.frame = CGRectMake(x-10, y-5, h+10, h+10);
        [_tapFaceBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-30"] forState:(UIControlStateSelected)];
        [_tapFaceBtn setBackgroundImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        //        _tapFaceBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [_tapFaceBtn addTarget:self action:@selector(tapFace:) forControlEvents:(UIControlEventTouchUpInside)];
        _tapFaceBtn.selected = YES;
    }
    return _tapFaceBtn;
}

- (UIImageView *)faceImageView
{
    if (!_faceImageView) {
        _faceImageView = [[UIImageView alloc]init];
        _faceImageView.image = self.image_face;
        _faceImageView.frame = CGRectMake(SCR_WIDTH/2-50, 150, 80, 80);
        _faceImageView.frame = self.rect_face;
        _faceImageView.alpha = 0.6;
        _faceImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _faceImageView;
}

- (UIImageView *)faceStyleImageView
{
    if (!_faceStyleImageView) {
        _faceStyleImageView = [[UIImageView alloc]init];
        _faceStyleImageView.image = self.image_facestyle;
        _faceStyleImageView.frame = self.rect_facestyle;
    }
    return _faceStyleImageView;
}

- (UIImageView *)hairImageView
{
    if (!_hairImageView) {
        _hairImageView = [[UIImageView alloc]init];
        _hairImageView.frame = self.rect_hair;
        _hairImageView.image = self.image_hair;
    }
    return _hairImageView;
}

#pragma mark - Action
- (void)tapFace:(UIButton *)btn
{
    if (btn.selected ) {
        self.collectionView.hidden = NO;
    }else
    {
        self.collectionView.hidden = YES;
    }
    btn.selected = !btn.selected;
    
}

- (IBAction)theNextStep:(id)sender {
    
    self.tapFaceBtn.selected = NO;
    self.collectionView.hidden = YES;
    
    UIGraphicsBeginImageContextWithOptions(self.backgroundView.bounds.size, NO, 0.0);
    
    [self.backgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //创建UIImageView并显示在界面上
    //    self.imageView_big.image  = viewImage;
    
    /*
     time: 2017.11.23
     @anthuor:song
     修改reason：替换下单流程
     
     ZZChooseViewController *chooseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ZZChooseViewController"];
     chooseVC.image = viewImage;
     [self.navigationController pushViewController:chooseVC animated:YES];
     */
    
    
    _sourceImage = viewImage;
    _imagedata = UIImagePNGRepresentation(_sourceImage);
    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        [ZJProgressHUD showProgress];
        MJWeakSelf
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [weakSelf uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                [weakSelf sourceCommonUpload];
            });
        });
    }else {
        
        [ZJProgressHUD showProgress];
        MJWeakSelf
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [weakSelf uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
                    selectC.selectImage =  _sourceImage;
                    selectC.imageUrl = _imageUrl;
                    selectC.thumbnailStr = _thumbnailStr;
                    [self.navigationController pushViewController:selectC animated:YES];
                });
            });
        });
        
        
    }
    
//    ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
//    selectC.selectImage = viewImage;
//    [self.navigationController pushViewController:selectC animated:YES];
    
}

- (UIImage *)cropWithRect:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.imageView_big.image CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

#pragma mark 手势触发事件
-(void)backGroundViewPinchAction:(UIPinchGestureRecognizer *)gesture{
    if (self.tapFaceBtn.selected) {
        UIView *view = self.faceImageView;
        if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformScale(view.transform, gesture.scale, gesture.scale);
            gesture.scale = 1;
        }
    }
}
-(void)backGroundViewPanAction:(UIPanGestureRecognizer *)gesture{
    if (self.tapFaceBtn.selected) {
        UIView *view = self.faceImageView;
        if (gesture.numberOfTouches == 1) {
            if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
                CGPoint transLation = [gesture translationInView:self.backgroundView];
                view.center = CGPointMake(view.center.x + transLation.x, view.center.y + transLation.y);
                [gesture setTranslation:CGPointZero inView:self.backgroundView];
            }
        }
    }
}

-(void)backGroundViewRotationAction:(UIRotationGestureRecognizer *)gesture{
    
    if (self.tapFaceBtn.selected) {
        UIView *view = self.faceImageView;
        view.transform = CGAffineTransformRotate(view.transform, gesture.rotation);
        gesture.rotation = 0;
    }
}

#pragma mark - gesture delegate
//手势向下传递
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        return YES;
    }else if ([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        return YES;
    }else{
        return NO;
    }
    
}

//拦截手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view.tag == 3) {
        return NO;
    }
    return YES;
    
}
#pragma mark - collectionView
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 5) {
        return self.imageArray.count;
    }else
    {
        return self.faceArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCollectionCell" forIndexPath:indexPath];
    cell.contentView.tag = 3;
    if (collectionView.tag == 4) {
        cell.imageView.image = [UIImage imageNamed:self.faceArray[indexPath.row]];
    }else
    {
        cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld",indexPath.row);
    if (collectionView.tag == 4) {
        NSArray *imageArray = @[@"军人-",@"军人2-",@"超人-"];
        if (indexPath.row > 0) {
            self.faceImageView.image = [UIImage imageNamed:imageArray[indexPath.row - 1]];
            
            CGFloat x =  self.rect_face.origin.x+1.5;
            CGFloat y = self.rect_face.origin.y-1;
            CGFloat w = self.rect_face.size.width;
            CGFloat h = self.rect_face.size.height+2;
            self.faceImageView.frame = CGRectMake(x, y, w, h);
            
        }else
        {
            CameraViewController *cameravc = [[CameraViewController alloc]init];
            __weak typeof(self) weakSelf = self;
            cameravc.imageblock = ^(UIImage *kaimage) {
                
                weakSelf.faceImageView.tintColor = [UIColor whiteColor];
                
                //                UIImage * img = [XPSFaceBeautify imageToFaceHandleImage:kaimage isTransparent:YES];
                [weakSelf.faceImageView setImage:kaimage];
                weakSelf.faceImageView.alpha = 0.6;
                
            };
            [self.navigationController pushViewController:cameravc animated:YES];
        }
    }else
    {
        if (_seleStyle == 0) {
            NSArray  *imageArray2 = @[@"发型20男",@"发型10男孩",@"发型19男",@"发型18男",@"发型11男孩"];
            [self.hairImageView setImage:[UIImage imageNamed:imageArray2[indexPath.row]]];
        }else
        {
            NSArray  *imageArray3 = @[@"男1",@"男2",@"男3",@"男4",@"男5"];
            [self.faceStyleImageView setImage:[UIImage imageNamed:imageArray3[indexPath.row]]];
        }
    }
    
}






#pragma mark --- 上传素材

- (void)uploadToImage {
    
    dispatch_group_enter(_group);
    [HWHttpTool post:API_ImageUpload params:@{@"height":@"200",@"width":@"200"} fileDatas:@[_imagedata] name:@"image" fileNames:@[@"finished.png"] mimeTypes:@[@"image/png"] success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"result"][@"original_image"]];
            _imageUrl = imageUrl;
            _thumbnailStr = [NSString stringWithFormat:@"%@",json[@"result"][@"original_image"]];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJProgressHUD hideHUD];
            });
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
        
        dispatch_group_leave(_group);
    } failure:^(NSError *error) {
        dispatch_group_leave(_group);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
        NSLog(@"%@",error);
    }];
    
}

- (void)sourceCommonUpload {
    MJWeakSelf
    [HWHttpTool post:API_CommonUpload params:@{@"image_url":_imageUrl,@"thumbnail":_thumbnailStr,@"user_id":USER_ID} success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSDictionary *sourceDic = json[@"result"][0];
            
            ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
            
            selectC.selectImage = _sourceImage;
            selectC.creative_id = sourceDic[@"creative_id"];
            [weakSelf.navigationController pushViewController:selectC animated:YES];
        }else {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
    }];
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

