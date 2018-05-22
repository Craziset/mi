//
//  BaseTableViewController.m
//  magicCamera
//
//  Created by LONG on 2017/12/2.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ZZProtocolViewController.h"
#import "ZZTextViewController.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    
    self.tableView.tableFooterView = [UIView new];
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"%@",segue.identifier);
    if (segue.identifier.length != 0) {
        if (segue.identifier.length == 1) {
            ZZTextViewController *vc = [segue destinationViewController];
            vc.numStr = segue.identifier;
        }else
        {
            ZZProtocolViewController *Vi = [segue destinationViewController];
            Vi.indexStr = segue.identifier;
        }
        
    }
   
    
}


@end
