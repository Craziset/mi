//
//  ZZChooseViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZChooseViewController.h"
#import "ChooseCollectionCell.h"
#import "ZZCreatViewController.h"

@interface ZZChooseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation ZZChooseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
//    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
    
}


- (IBAction)nextSetp:(id)sender {
    
    ZZCreatViewController *zzcreatVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ZZCreatViewController"];
    zzcreatVC.image = self.image ;
    [self.navigationController pushViewController:zzcreatVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"aaaaaaaa");
    
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
