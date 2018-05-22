//
//  SongExpressVC.m
//  magicCamera
//
//  Created by 宋建 on 2017/11/16.
//  Copyright © 2017年 张展展. All rights reserved.
//  快递方式

#import "SongExpressVC.h"
@interface SongExpressVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *arr0;
    NSArray *arr1;
    NSMutableArray *cellimages;
    NSString *timeStr;//选择时间
    
}
@property(nonatomic,strong)UITableView *songTab;
@end
@implementation SongExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cellimages = [NSMutableArray arrayWithCapacity:0];
    arr0 = @[@"配送方式: ",@"普通快递"];
    arr1 = @[@"选择时间:",@"工作日、周六、节假日均可派送",@"仅工作日派送",@"仅周六日、节假日派送"];
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.songTab];
}
-(UITableView *)songTab{
    if (_songTab == nil) {
        self.songTab  =[[UITableView alloc]initWithFrame:CGRectMake(0, 5, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        self.songTab.delegate = self;
        self.songTab.dataSource = self;
        _songTab.estimatedSectionHeaderHeight =  0.0f;
    }
    return _songTab;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 40;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
      return 10.0f;
    }else{
        return 50.0f;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        view.backgroundColor  = BackColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 18, WIDTH-40, 40);
        [btn setBackgroundColor:RGBA(240, 218, 81, 1)];
        [btn setTitle:@"确定" forState:0];
        [btn setTintColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(ConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 6;
        [view addSubview:btn];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identener = @"sogcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identener];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identener];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        cell.textLabel.text = arr0[indexPath.row];
        if (indexPath.row==0) {
            cell.textLabel.textColor =  [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            UIImage * icon = [UIImage imageNamed:@"shop_deselect"];
            CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
            UIGraphicsEndImageContext();//*3
        }
    }else{
        cell.textLabel.text = arr1[indexPath.row];
        if (indexPath.row==0) {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            UIImage * icon = [UIImage imageNamed:@"shop_deselect"];
            CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
            UIGraphicsEndImageContext();//*3
            [cellimages addObject:cell.imageView];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.section == 1) {
            for (UIImageView *img in cellimages) {
                UIImage * icon = [UIImage imageNamed:@"shop_deselect"];
                CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
                UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
                CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
                [icon drawInRect:imageRect];
                img.image = UIGraphicsGetImageFromCurrentImageContext();//*2
                UIGraphicsEndImageContext();//*3
            }
        }
        UIImage * icon = [UIImage imageNamed:@"logistics_select"];
        CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
        UIGraphicsEndImageContext();//*3
    }
    if (indexPath.section == 1) {
        timeStr = arr1[indexPath.row];
    }
}

-(void)ConfirmBtn{
    _timeString(timeStr);
    SongExpressVC *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    [self.navigationController popToViewController:vc animated:YES];
    
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
