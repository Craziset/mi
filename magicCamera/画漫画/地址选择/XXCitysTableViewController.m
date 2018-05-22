//
//  XXCitysTableViewController.m
//  XXTableView
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 corepass. All rights reserved.
//

#import "XXCitysTableViewController.h"
#import "XXAreasTableViewController.h"

@interface XXCitysTableViewController ()

@end

@implementation XXCitysTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.citis.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"citiCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.citis[indexPath.row][@"city"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *areas = self.citis[indexPath.row][@"areas"];
    self.areasVC.provinceStr = self.provinceStr;
    self.areasVC.cityName = self.citis[indexPath.row][@"city"];
    self.areasVC.areas = areas;
    
    [self.navigationController pushViewController:self.areasVC animated:YES];
}


@end
