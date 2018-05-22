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
#import "ZZMerchandisCollectionViewMode.h"
#import "ZZSureMerViewController.h"
@interface ZZMerchandiseViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{
    NSDictionary *productDic;
    NSInteger _myitem;
}

@property(nonatomic,strong)NSMutableArray *objectSong;//存储数组对象
@property(nonatomic,strong)NSMutableArray *product_temp_idArr;//product_temp_id数组
@property(nonatomic,strong)NSMutableArray *cellArr;//存储数组对象
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (nonatomic, strong) UIImage *tShirtImage; //衣服

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
    self.nextButton.layer.cornerRadius = 5.0f;
    [self FlowLayout];
    // Do any additional setup after loading the view.
    [self songReqsut];
    self.view.backgroundColor = BackColor;
    self.nextButton.hidden = YES;
    _myitem = -1;
//    self.nextStep.layer.cornerRadius = 2;
}
// 请求数据
-(void)songReqsut{
    [ZJProgressHUD showProgress];
    [afnObject POST:[NSString stringWithFormat:@"%@%@",SongMainUrl,@"api/product-temp/product-templates"] parameters:nil success:^(id responseObject) {
        NSLog(@"res=======%@",responseObject);
        [ZJProgressHUD hideAllHUDs];
        for (NSDictionary *dic in responseObject) {
            ZZMerchandisCollectionViewMode *model = [ZZMerchandisCollectionViewMode modelWithDictionary:dic];
            [self.objectSong addObject:model];
            [self.product_temp_idArr addObject:dic]; //这里是储存的对象
        }
        [self.merchandiseConView reloadData];
    } failure:^(id error) {
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
    [cell configureCellWithModel:self.objectSong[indexPath.section]];
    cell.backgroundColor = [UIColor whiteColor];
    [self.cellArr addObject:cell];
    return cell;
}

- (IBAction)nextclicked:(id)sender {
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (ZZMerchandisCollectionViewCell *cell in collectionView.visibleCells) {
        cell.contentView.layer.cornerRadius = 2;
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = RGBA(255, 255, 255, 1).CGColor;
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderWidth = 2;
    cell.contentView.layer.borderColor = YEllOWColor.CGColor;
    _myitem = indexPath.item;
    
    self.tShirtImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:API_ImageURL([self.objectSong[indexPath.section]thumbnail])]]];
    
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
    }else
    {
        productDic = self.product_temp_idArr[_myitem];
        NSString *product_temp_id = productDic[@"product_temp_id"];
        if (product_temp_id.length>0) {
            ZZSureMerViewController *sure = [[ZZSureMerViewController alloc]init];
            sure.NextproductDic = productDic;
            sure.selectImage = self.selectImage;
            sure.tShirtImage = self.tShirtImage;
            [self.navigationController pushViewController:sure animated:YES];
        }else{
            [XHToast showBottomWithText:@"请先选择" bottomOffset:200 duration:5.0f];
        }
    }
    
}



@end
