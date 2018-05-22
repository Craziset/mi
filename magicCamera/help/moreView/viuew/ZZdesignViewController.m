//
//  ZZdesignViewController.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZdesignViewController.h"
#import "ZZdesignCollectionViewCell.h"
#import "MySourceModel.h"
@interface ZZdesignViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger _page;
    NSInteger _totalPage;
}
@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation ZZdesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self FlowLayout];
    // Do any additional setup after loading the view.
    self.designCollectionview.backgroundColor = BackColor;
    
    [self requestSourceData];
    _page = 1;
    MJWeakSelf
    self.designCollectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page =1;
        [weakSelf requestSourceData];
    }];
    self.designCollectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestSourceData];
        
    }];
}

-(void)FlowLayout
{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //代理设置
    self.designCollectionview.delegate=self;
    self.designCollectionview.dataSource=self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.designCollectionview registerNib:[UINib nibWithNibName:@"ZZdesignCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"desCollec"];
    
    
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ViewW/2.0f-15 , ViewH/3.3f);
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
//定义每个Section的margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZdesignCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"desCollec" forIndexPath:indexPath];
    if (self.isType) {
        [cell.deleteBtn setImage:[UIImage imageNamed:@"转发.png"] forState:(UIControlStateNormal)];
        [cell.sharBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    MySourceModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.cellBlock = ^(NSInteger iii) {
        if (self.isType == NO) {
            if (iii == 0) {
                [self shareWithImageUrl:model.original_image thumbnail:model.thumbnail];
            }else {
                [self deleteUserSourceWithId:model.creative_id];
            }
        }else {
            if (iii == 1) {
                [self shareWithImageUrl:model.original_image thumbnail:model.thumbnail];
            }
        }
    };
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"moreView" bundle:nibBundleOrNil];
        ZZdesignViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"designView"];
        self = message;
    }
    return  self;
}



- (void)shareWithImageUrl:(NSString *)url thumbnail:(NSString *)thumbnail{
    //分享的标题
    NSString *textToShare = @"米6";
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:thumbnail] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //分享的图片
        
        //分享的url
        NSURL *urlToShare = [NSURL URLWithString:url];
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        NSArray *activityItems = @[textToShare,image, urlToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        //不出现在活动项目
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [self presentViewController:activityVC animated:YES completion:nil];
        // 分享之后的回调
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"completed");
                //分享 成功
            } else  {
                NSLog(@"cancled");
                //分享 取消
            }
        };
    }];
    
}


- (void)requestSourceData {
    NSString *url = API_UserSource;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"per_page"] = @"10";
    dic[@"page"] = @(_page);
    if (self.isType == NO) { //我的
        dic[@"user_id"] = USER_ID;
    }else {
        url = API_SystemSource;
    }
    MJWeakSelf
    [HWHttpTool post:url params:dic success:^(id json) {
        if (_page == 1) {
            [self.dataArray removeAllObjects];
        }
        
            if (weakSelf.isType == NO) {
                _totalPage = [json[@"result"][@"total_page"] integerValue];
                NSArray *array = [MySourceModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"data"]];
                if (_page <= _totalPage) {
                    [weakSelf.dataArray addObjectsFromArray:array];
                    _page ++;
                    [weakSelf.designCollectionview.mj_footer endRefreshing];
                }else {
                    [weakSelf.designCollectionview.mj_footer endRefreshingWithNoMoreData];
                }
                [weakSelf.designCollectionview.mj_header endRefreshing];
            }else {
                _totalPage = [json[@"total_page"] integerValue];
                NSArray *array = [MySourceModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                if (_page <= _totalPage) {
                    [weakSelf.dataArray addObjectsFromArray:array];
                    _page ++;
                    [weakSelf.designCollectionview.mj_footer endRefreshing];
                }else {
                    [weakSelf.designCollectionview.mj_footer endRefreshingWithNoMoreData];
                }
                [weakSelf.designCollectionview.mj_header endRefreshing];
            }
        
        
        [weakSelf.designCollectionview reloadData];
    } failure:^(NSError *error) {
        [weakSelf.designCollectionview.mj_footer endRefreshing];
        [weakSelf.designCollectionview.mj_header endRefreshing];
        
    }];
}

- (void)deleteUserSourceWithId:(NSString *)creativeid {
    MJWeakSelf
    [HWHttpTool post:API_DeleteUserSource params:@{@"user_id":USER_ID,@"creative_id":creativeid} success:^(id json) {
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
            [weakSelf.designCollectionview.mj_header beginRefreshing];
        }else {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
