//
//  ZZsetnewViewController.m
//  magicCamera
//
//  Created by user on 2017/11/7.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZsetnewViewController.h"
#import "ZZsetnewTableViewCell.h"
#import "settincell.h"
#import "LBClearCacheTool.h"
#import "ZZAboutUSViewController.h"
#import "ZZProtocolViewController.h"
#import "ZZTextViewController.h"
@interface ZZsetnewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *messageArray;

@property(nonatomic,strong)NSArray*imgarr;
@end

@implementation ZZsetnewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建自定义视图
    UIView *leftBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftBtnView.backgroundColor = [UIColor clearColor];
    //加载自定义视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    
    //后退按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 8, 25, 25);
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navClick1) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn];
    
    //关闭按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn.right+20, 8, 25, 25);
    [btn2 setImage:[UIImage imageNamed:@"主页"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(navClick2) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn2];
    
    self.setnewTableView.backgroundColor=[UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    self.setnewTableView.tableFooterView = [self setfootableview];
    [self.setnewTableView registerNib:[UINib nibWithNibName:@"ZZsetnewTableViewCell" bundle:nil] forCellReuseIdentifier:@"setnewcell"];
    [self.setnewTableView registerNib:[UINib nibWithNibName:@"settincell" bundle:nil] forCellReuseIdentifier:@"settincell"];
    self.messageArray = @[@"服务协议",@"五星好评",@"关于我们"];
    self.imgarr=@[@"setting1",@"setting2",@"setting3"];
    
    // Do any additional setup after loading the view.
}
-(void)navClick1{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    [self.navigationController popToViewController:vc animated:YES];
}
-(void)navClick2{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 3;
    }else
    {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZZsetnewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setnewcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        settincell*cell=[tableView dequeueReusableCellWithIdentifier:@"settincell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.settlab.text = self.messageArray[indexPath.row];
        cell.imge.image=[UIImage imageNamed:self.imgarr[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uotCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"uotCell"];
            UILabel *label = [[UILabel alloc]init];
            label.text = @"退出登录";
            label.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(0);
            }];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                //服务协议
                ZZTextViewController *vi =initVCFromSTBWithIdentifer(@"Main", [ZZTextViewController description]);
                vi.numStr = @"0";
                [self.navigationController pushViewController:vi animated:YES];
            }
                break;
            case 1:
            {
                //商店评分
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1271657765?mt=8"]];
                
            }
                break;
            case 2:
            {
                //关于我们
                
                ZZAboutUSViewController *vi =initVCFromSTBWithIdentifer(@"Main", [ZZAboutUSViewController description]);
                [self.navigationController pushViewController:vi animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    }
    
    if (indexPath.section ==2) {
        [ZZUserManager shareManager].isLogin = @NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
//    if (section == 1) {
//        return 45*rateh;
//    }
    return 15;
}




-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"moreView" bundle:nibBundleOrNil];
        ZZsetnewViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"setnew"];
        self = message;
    }
    return  self;
}
-(UIView*)setfootableview{
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 45*rateh)];
    view.backgroundColor=[UIColor redColor];
    UIButton*btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, kScreenW, 45*rateh) ];
    btn.backgroundColor=[UIColor whiteColor];
    // [btn setTitle: forState:uibtt];
    LBClearCacheTool*LbCashe=[[LBClearCacheTool alloc]init];
    float fileSize=[LbCashe clearCache];
    
    if (fileSize  == 0) {
        // btn.titleLabel.text = @"清除缓存";
        [btn setTitle:@"清除缓存" forState:UIControlStateNormal];
    }else {
        NSString*cashdata = [NSString stringWithFormat:@"清除缓存%.2fM",fileSize];
        [btn setTitle:cashdata forState:UIControlStateNormal];
    }
    
    [btn addTarget:self action:@selector(clearcashdata:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [view addSubview:btn];
    
    return view;
}


-(void)clearcashdata:(UIButton*)btn{
    //清除缓存
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定清除缓存吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //创建一个取消和一个确定按钮
    UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
    UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        LBClearCacheTool*LbCashe=[[LBClearCacheTool alloc]init];
        [LbCashe removeChace];
        NSString*cashdata = [NSString stringWithFormat:@"清除缓存0M"];
        [btn setTitle:cashdata forState:UIControlStateNormal];
        
    }   ];
    //将取消和确定按钮添加进弹框控制器
    [alert addAction:actionCancle];
    [alert addAction:actionOk];
    //显示弹框控制器
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


@end

