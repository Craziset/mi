//
//  XXCityTableViewController.m
//  XXTableView
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 corepass. All rights reserved.
//

#import "XXProvinceTableViewController.h"
#import "XXCitysTableViewController.h"
#import "XXAreasTableViewController.h"

@interface XXProvinceTableViewController ()

@property (nonatomic, strong) NSMutableArray *allCityArray;
@property (nonatomic, strong) NSMutableDictionary *cityDic;

@end

@implementation XXProvinceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allCityArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    NSDictionary *cityDic = self.allCityArray[indexPath.row];
    NSString *cityStr = cityDic[@"state"];
    cell.textLabel.text = cityStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cityDic = self.allCityArray[indexPath.row];
    NSArray *cities = cityDic[@"cities"];
    NSArray *areas = cities[0][@"areas"];
    NSString *cityStr = cityDic[@"state"];
    if (areas.count == 0) {
        //直辖市
        NSLog(@"直辖市");
        self.areasVC.cityName = cityStr;
        self.areasVC.areas = cities;
        self.areasVC.provinceStr = cityStr;
        [self.navigationController pushViewController:self.areasVC animated:YES];
    }else {
        //非直辖市
        NSLog(@"非直辖市");
        XXCitysTableViewController *cityVC = initVCFromSTBWithIdentifer(@"Main", @"XXCitysTableViewController");
        
        cityVC.areasVC = self.areasVC;
        cityVC.citis = cities;
        cityVC.provinceStr = cityStr;
        [self.navigationController pushViewController:cityVC animated:YES];
        
    }
    
    
}




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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)allCityArray {
    if (!_allCityArray) {
        NSBundle *bundle=[NSBundle mainBundle];
        NSString *path=[bundle pathForResource:@"address" ofType:@"plist"];
        _allCityArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    }
    return _allCityArray;
}



@end
