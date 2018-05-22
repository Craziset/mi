//
//  ZZMerchandiseViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/17.
//  Copyright © 2017年 张展展. All rights reserved.
//  选图进行下一步下单操作
static NSString *kheaderIdentifier = @"mercell";
#import "ZZMerchandiseViewController.h"
#import "ZZMerchandisCollectionViewCell.h"
#import "ProductModel.h"
#import "ZZSureMerViewController.h"
#import "ZZProductTempModel.h"
#import "ZZCustomZoneModel.h"
#import "MJRefresh.h"
#import "ZZLoginViewController.h"
#import "QuartView.h"
@interface ZZMerchandiseViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{
    NSDictionary *productDic;
    NSInteger _myitem;
    NSInteger _dataPage;
    NSInteger _totalPage;
}

@property(nonatomic,strong)NSMutableArray *objectSong;//存储数组对象
@property(nonatomic,strong)NSMutableArray *product_temp_idArr;//product_temp_id数组
@property(nonatomic,strong)NSMutableArray *cellArr;//存储数组对象
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (nonatomic, strong) UIImage *tShirtImage; //衣服

@property (nonatomic, strong) NSString *tshirtUrl;
@property (nonatomic, copy) NSString *product_temp_id;//选中的商品id
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (nonatomic, strong)NSString* thumbnail;
@property (nonatomic, copy)NSString* designModel;
@property (nonatomic, assign)float xishu;


@end
@implementation ZZMerchandiseViewController
-(NSMutableArray *)objectSong{
    if (_objectSong==nil) {
        _objectSong = [NSMutableArray arrayWithCapacity:0];
    }
    return _objectSong;
}
-(NSMutableArray *)product_temp_idArr{
    if (_product_temp_idArr==nil) {
        _product_temp_idArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _product_temp_idArr;
}
-(NSMutableArray *)cellArr{
    if (_cellArr==nil) {
        _cellArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.xishu = (ViewW/2.0f-8)/100;
    
    self.nextStep.layer.cornerRadius = 7.0f;
    self.nextStep.backgroundColor = YEllOWColor;
    [self FlowLayout];
    // Do any additional setup after loading the view.
    [self songReqsut];
    self.view.backgroundColor = BackColor;
//    self.nextButton.hidden = YES;
    _myitem = -1;
    _dataPage = 1;
    MJWeakSelf
    self.merchandiseConView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _dataPage = 1;
        [weakSelf songReqsut];
    }];
    
    self.merchandiseConView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf songReqsut];
    }];
    
//    self.nextStep.layer.cornerRadius = 2;
    
//    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
//    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
}
// 请求数据
-(void)songReqsut{
    [ZJProgressHUD showProgress];
    //获取所有模板
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"user_id"] = @"0";
    dic[@"page"] = @(_dataPage);
    dic[@"per_page"] = @10;
//    dic[@"platform"] = @"ios";
    MJWeakSelf
    [afnObject POST:API_Producttemplates parameters:dic success:^(id responseObject) {
        NSLog(@"res=======%@",responseObject);
        [ZJProgressHUD hideAllHUDs];
        
        if ([responseObject[@"state"] isEqualToString:@"M00000"]) {
            if (_dataPage == 1) {
                [weakSelf.objectSong removeAllObjects];
            }
            NSArray *dataArray = [ProductModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            
            _totalPage = [responseObject[@"result"][@"total_page"] integerValue];
            if (_dataPage <= _totalPage) {
                _dataPage ++;
                [weakSelf.objectSong addObjectsFromArray:dataArray];
                [weakSelf.merchandiseConView.mj_footer endRefreshing];
                
            }else {
                [weakSelf.merchandiseConView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }
        
        [weakSelf.merchandiseConView reloadData];
        [weakSelf.merchandiseConView.mj_header endRefreshing];
    } failure:^(id error) {
        [weakSelf.merchandiseConView.mj_footer endRefreshing];
        [weakSelf.merchandiseConView.mj_header endRefreshing];
        [ZJProgressHUD hideAllHUDs];
    } Cahche:NO];
}

-(void)FlowLayout
{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //代理设置
    self.merchandiseConView.delegate=self;
    self.merchandiseConView.dataSource=self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.merchandiseConView registerNib:[UINib nibWithNibName:@"ZZMerchandisCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kheaderIdentifier];
    self.merchandiseConView.backgroundColor = BackColor;
    self.merchandiseConView.delaysContentTouches = false;
    
    
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ViewW/2.0f-8, ViewH/3.2f);
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{    return self.objectSong.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZMerchandisCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
    [cell configureCellWithModel:self.objectSong[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    ZZProductTempModel* tempModel = [self.objectSong[indexPath.row] colors][0];
    
    if (tempModel.coord.count != 0)
    {
        cell.imgView.hidden = NO;
        cell.orgImage.hidden = YES;
        NSString* strA = tempModel.coord[0];
        NSString* strB = tempModel.coord[1];

        NSArray* arrA = [strA componentsSeparatedByString:@"|"];
        NSArray* arrB = [strB componentsSeparatedByString:@"|"];

        cell.imgView.A1Arr = arrA;
        cell.imgView.A2Arr = arrB;
        cell.imgView.image = self.selectImage;
        cell.imgView.width = cell.frame.size.width/2-20;
        cell.imgView.height = cell.frame.size.height/2-20;
        cell.imgView.xishu = _xishu;
        [cell.imgView setNeedsDisplay];
    }else
    {
        cell.imgView.hidden = YES;
        cell.orgImage.hidden = NO;
        
        
//            cell.orgImage = [[UIImageView alloc]initWithImage:self.selectImage];
        [cell.orgImage setImage:self.selectImage];
            cell.orgImage.center = CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2 - 30);
            cell.orgImage.bounds = CGRectMake(0, 0,cell.frame.size.width/2-20, cell.frame.size.height/2-20);
       
    }
    
    
    
    
    [self.cellArr addObject:cell];
    return cell;
}

- (IBAction)nextclicked:(id)sender {
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (ZZMerchandisCollectionViewCell *cell in collectionView.visibleCells) {
        cell.contentView.layer.cornerRadius = 5;
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = RGBA(255, 255, 255, 1).CGColor;
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderWidth = 2;
    cell.contentView.layer.borderColor = YEllOWColor.CGColor;
    _myitem = indexPath.section;
    
    ProductModel *model = self.objectSong[indexPath.row];
    ZZProductTempModel *colorModel = model.colors[0];
    ZZCustomZoneModel *zoneMeol = colorModel.temp_custom_zones[0];
    self.tshirtUrl =  zoneMeol.original_image;
    self.thumbnail = zoneMeol.thumbnail;
    self.product_temp_id = model.product_temp_id;
    //TODO:designmodel
    self.designModel = model.design_mode;
    /*
     ZZProductTempModel *colorModel = ExhbitMode.colors[0];
     ZZCustomZoneModel *zoneMeol = colorModel.temp_custom_zones[0];
     [self.imageMerchandisCollection sd_setImageWithURL:[NSURL URLWithString:zoneMeol.thumbnail] placeholderImage:[UIImage imageNamed:@"common_nopic"]];
     */
//    self.tShirtImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
  
    
}
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZMerchandisCollectionViewCell * cell = (ZZMerchandisCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = BackColor;
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZMerchandisCollectionViewCell * cell = (ZZMerchandisCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZMerchandiseViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"Merchandise"];
        self = message;
    }
    return  self;
}
- (IBAction)clickNextStep:(id)sender {
    
    if (_myitem == -1) {
        [ZJProgressHUD showStatus:@"请选择商品" andAutoHideAfterTime:1.1];
    }else {
        if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
            ProductModel *model = self.objectSong[_myitem];
            if (model.product_temp_id.length>0) {
                
                ZZSureMerViewController *sure = [[ZZSureMerViewController alloc]init];
                sure.temp_id = self.product_temp_id;
                sure.selectImage = self.selectImage;
                sure.tagModel = self.tagModel;
                sure.picModel = self.picModel;
                sure.thumbnail1 = self.thumbnail;
                sure.creative_id = self.creative_id;
                sure.design_model = self.designModel;
                [self.navigationController pushViewController:sure animated:YES];
            }else{
                [XHToast showBottomWithText:@"请先选择" bottomOffset:200 duration:5.0f];
            }
        }else
        {
            
            ZZLoginViewController *loginvc= initVCFromSTBWithIdentifer(@"Login", @"ZZLoginViewController");
            MJWeakSelf
            loginvc.loginBlock = ^{
                NSLog(@"登录成功了");
                [weakSelf sourceCommonUpload];
            };
            [self.navigationController pushViewController:loginvc animated:YES];
        }
        
    }
    
}

- (void)sourceCommonUpload {
    [ZJProgressHUD showProgress];
    MJWeakSelf
    [HWHttpTool post:API_CommonUpload params:@{@"image_url":self.imageUrl,@"thumbnail":self.thumbnailStr,@"user_id":USER_ID} success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSDictionary *sourceDic = json[@"result"][0];
            
            weakSelf.creative_id = sourceDic[@"creative_id"];
            
            ProductModel *model = weakSelf.objectSong[_myitem];
            if (model.product_temp_id.length>0) {
                
                ZZSureMerViewController *sure = [[ZZSureMerViewController alloc]init];
                sure.temp_id = weakSelf.product_temp_id;
                sure.selectImage = weakSelf.selectImage;
                sure.tagModel = weakSelf.tagModel;
                sure.picModel = weakSelf.picModel;

                sure.creative_id = sourceDic[@"creative_id"];
                
                [weakSelf.navigationController pushViewController:sure animated:YES];
            }else{
                [XHToast showBottomWithText:@"请先选择" bottomOffset:200 duration:5.0f];
            }
            
        }else {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
    }];
}





@end
