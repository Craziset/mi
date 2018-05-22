//
//  SongChoosePicViewController.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//  画图完成之后点击下一步进行选图出现的界面，暂时分开了，不用原工程的

#import "SongChoosePicViewController.h"

@interface SongChoosePicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *songCollect;
@end
@implementation SongChoosePicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:_songCollect];
}

-(UICollectionView *)songCollect{
    if (_songCollect==nil) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake(110, 150);
        //2.初始化collectionView
        _songCollect = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _songCollect.delegate = self;
        _songCollect.dataSource = self;
        _songCollect.backgroundColor = [UIColor clearColor];
    }
    return _songCollect;
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

@end
