//
//  TicketControlViews.m
//  magicCamera
//
//  Created by jianpan on 2017/11/17.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "TicketControlViews.h"
#import "SongExpressVC.h"
@interface TicketControlViews ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSArray *arr0;
    NSArray *arr1;
    NSMutableArray *cellimages;
    UITextField *tickText; // 输入发票类型
    int count;
    
}

@property(nonatomic,strong)UITableView *songTab;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation TicketControlViews

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 3;
    // Do any additional setup after loading the view.
    cellimages = [NSMutableArray arrayWithCapacity:0];
    arr0 = @[@"发票内容: ",@"默认",@"不开发票"];
    arr1 = @[@"发票类型:",@"纸质发票"];
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.songTab];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    view.backgroundColor  = BackColor;
    [view addSubview:self.btn];
    self.songTab.tableFooterView = view;
    
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
    
    return count;
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
        return 3;
    }else{
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==count-1) {
        return 50.0f;
    }else{
        return 10.0f;
    }
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == count-1) {
//
//        return view;
//    }
//    return nil;
//}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(20, 10, WIDTH-40, 40);
        [_btn setBackgroundColor:RGBA(240, 218, 81, 1)];
        [_btn setTitle:@"确定" forState:0];
        [_btn setTintColor:[UIColor whiteColor]];
        [_btn addTarget:self action:@selector(ConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.cornerRadius = 6;
        
    }
    return _btn;
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
            UIImage * icon;
            if (indexPath.row==1) {
            icon = [UIImage imageNamed:@"logistics_select"];
            }else{
            icon = [UIImage imageNamed:@"shop_deselect"];}
            CGSize itemSize = CGSizeMake(18, 18);//固定图片大小为15*15
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
            UIGraphicsEndImageContext();//*3
            [cellimages addObject:cell.imageView];
        }
    }else if(indexPath.section == 1){
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
        }
    }else{
        if (indexPath.row==0) {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.text = @"发票类型：";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            tickText = [[UITextField alloc]initWithFrame:CGRectMake(10, 8, WIDTH-20, 24)];
            tickText.delegate = self;
            tickText.backgroundColor = BackColor;
            tickText.borderStyle = UITextBorderStyleNone;
            tickText.placeholder = @" 个人";
            tickText.clearButtonMode = UITextFieldViewModeAlways;
            tickText.font = [UIFont systemFontOfSize:14];
            [cell addSubview:tickText];
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            count= 3;
        }else{
            count=1;
        }
        [self.songTab reloadData];
    }else if(indexPath.section == 1) {
        if (indexPath.row == 1) {
            count = 2;
        }
    }
    if (indexPath.row > 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.section == 0) {
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
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}
-(void)ConfirmBtn{
    
    if (self.block) {
        NSString *ticket;
        if (count == 3) {
            ticket = @"默认";
        }else if (count == 2) {
            ticket = [NSString stringWithFormat:@"纸质发票：%@",tickText.text];
        }else if (count == 1) {
            ticket = @"不开发票";
        }
        self.block(ticket);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
