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
@interface ZZMerchandiseViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray *objectSong;//存储数组对象
@property(nonatomic,strong)NSMutableArray *product_temp_idArr;//product_temp_id数组
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self FlowLayout];
    // Do any additional setup after loading the view.
    [self songReqsut];
}
// 请求数据
-(void)songReqsut{
    [afnObject POST:[NSString stringWithFormat:@"%@%@",SongMianUrl,@"api/product-temp/product-templates"] parameters:nil success:^(id responseObject) {
        for (NSDictionary *dic in responseObject) {
            ZZMerchandisCollectionViewMode *model = [ZZMerchandisCollectionViewMode modelWithDictionary:dic];
            [self.objectSong addObject:model];
            [self.product_temp_idArr addObject:dic[@"product_temp_id"]];
        }
        [self.merchandiseConView reloadData];
    } failure:^(id error) {
        
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
    
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ViewW/2.0f-10 , ViewH/3.8f);
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);//分别为上、左、下、右
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.objectSong.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZMerchandisCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
    [cell configureCellWithModel:self.objectSong[indexPath.section]];
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}


- (IBAction)nextclicked:(id)sender {
    
    ZZSureMerViewController *sure = [[ZZSureMerViewController alloc]init];
    [self.navigationController pushViewController:sure animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = BackColor;
  
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
        ZZMerchandiseViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"Merchandise"];
        self = message;
    }
    return  self;
}
@end
