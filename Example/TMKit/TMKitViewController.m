//
//  TMKitViewController.m
//  TMKit
//
//  Created by Teemo on 05/16/2017.
//  Copyright (c) 2017 Teemo. All rights reserved.
//

#import "TMKitViewController.h"
#import <TMKit/TMKit.h>

@interface TMKitViewController ()<
UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation TMKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TMKitDEMO";
    self.mainTableView = [UITableView new];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.frame = self.view.bounds;
    self.dataArray = @[@"Data",@"Date",@"DB",@"Log",@"String",@"UI",@"Version"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

@end
