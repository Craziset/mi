//
//  XXAreasTableViewController.m
//  XXTableView
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 corepass. All rights reserved.
//

#import "XXAreasTableViewController.h"
#import "XXAddAddressTableVC.h"
@interface XXAreasTableViewController ()
{
    NSString *_areaStr;
}
@end

@implementation XXAreasTableViewController

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

    return self.areas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"areaCell" forIndexPath:indexPath];
    if ([self.areas[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = self.areas[indexPath.row];
    }else {
        cell.textLabel.text = self.areas[indexPath.row][@"city"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.areas[indexPath.row] isKindOfClass:[NSString class]]) {
        _areaStr = self.areas[indexPath.row];
    }else {
        _areaStr = self.areas[indexPath.row][@"city"];
    }
    
    if (self.addBlock) {
        self.addBlock(self.provinceStr,self.cityName, _areaStr);
    }
    for (NSInteger i = 0; i < self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:[XXAddAddressTableVC class]]) {
            [self.navigationController popToViewController: self.navigationController.viewControllers[i] animated:YES];
        }
    }
    
    
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
