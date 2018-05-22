//
//  MyOderTalViewController.m
//  magicCamera
//
//  Created by jianpan on 2017/11/14.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "MyOderTalViewController.h"
#import "YJSegmentedControl.h"
#import "ControlViews/songOderViewController1.h"
#import "ControlViews/songOderViewController2.h"
#import "ControlViews/songOderViewController3.h"
#import "ControlViews/songOderViewController4.h"
#import "songOderViewController5.h"
#import "ThirdBtnView.h"
@interface MyOderTalViewController ()<YJSegmentedControlDelegate,ThirdBtnViewDelegate>{
     NSArray *logTypeArrM;
    UIViewController *oldView;
    NSInteger tagSection;
}

@property(nonatomic,unsafe_unretained)NSInteger selectIndex;
@property(nonatomic,strong)songOderViewController1 *buyVC;
@property(nonatomic,strong)songOderViewController2 *sellVC;
@property(nonatomic,strong)songOderViewController3 *buyV;
@property(nonatomic,strong)songOderViewController4 *bu;
@property(nonatomic,strong)songOderViewController5 *bu5;
@property (nonatomic,strong) NSMutableArray *viewControllerArray;
@property (assign,nonatomic) BOOL adjustScreen;
@property (nonatomic,strong) ThirdBtnView * btnView;
@end
@implementation MyOderTalViewController
-(void)viewWillAppear:(BOOL)animated{
    self.selectIndex = _StuatsTag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    // Do any additional setup after loading the view.
    NSMutableArray *btnNameArr = [NSMutableArray arrayWithObjects:@"全部", @"待付款", @"待发货",@"待收货", @"售后",nil];
    _buyVC = [[songOderViewController1 alloc]init];
    _sellVC = [[songOderViewController2 alloc]init];
    _buyV = [[songOderViewController3 alloc]init];
    _bu = [[songOderViewController4 alloc]init];
    _bu5 = [[songOderViewController5 alloc]init];
    self.viewControllerArray = [NSMutableArray arrayWithObjects:_buyVC,_sellVC,_buyV,_bu,_bu5,nil];
    self.btnView = [[ThirdBtnView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, WIDTH, 40*HEIGHT/XMultiple) WithBtnNameArr:btnNameArr WithNsinteg:_StuatsTag];
    self.btnView.backgroundColor = [UIColor whiteColor];
    self.btnView.delegate = self;
    [self.view  addSubview:_btnView];

}

#pragma mark -------
#pragma mark ThirdBtnViewDelegateDelegate
-(void)didtapBtn:(UIButton *)btn{
    
    [self changeViewControllerButtonClick:btn];
}

- (void)changeViewControllerButtonClick:(UIButton *)sender
{
    self.selectIndex = sender.tag;
}
#pragma mark ButtonClick
-(void)setSelectIndex:(NSInteger)selectIndex
{
    if (_selectIndex>=selectIndex)
    {
        oldView =[self.viewControllerArray objectAtIndex:selectIndex];
        [oldView.view removeFromSuperview];
    }
    UIViewController *ewView =[self.viewControllerArray objectAtIndex:selectIndex];
    tagSection = selectIndex;
    ewView.view.frame = CGRectMake(0, CGRectGetMaxY(_btnView.frame)+5,WIDTH, HEIGHT);
    [self.view addSubview:ewView.view];
    [self addChildViewController:ewView];
    _StuatsTag =selectIndex;
    
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
