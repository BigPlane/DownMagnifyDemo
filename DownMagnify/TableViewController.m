//
//  TableViewController.m
//  DownMagnify
//
//  Created by Colin on 15-9-24.
//  Copyright (c) 2015年 CH. All rights reserved.
//

#import "TableViewController.h"

const CGFloat TopViewH = 300;
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface TableViewController () <UITableViewDataSource>

@property (nonatomic, weak) UIImageView *topView;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    
    // 设置内边距让TableView的contentView往下移动
    self.tableView.contentInset = UIEdgeInsetsMake(TopViewH / 2, 0, 0, 0);
    
    UIImageView *topView = [[UIImageView alloc] init];
   
    // 初始位置
    topView.frame = CGRectMake(0, -TopViewH, ScreenW, TopViewH);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImage *image = [UIImage imageNamed:@"Big.jpg"];
    topView.image = image;

    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
}

#pragma mark － UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"下拉放大--%ld", indexPath.row];
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    -150 - scrollView.contentOffset.y;
    
    // 下拉距离
    CGFloat downDistance = -TopViewH / 2 - scrollView.contentOffset.y;
    if (downDistance >= 0)
    {
//        CGRect frame = self.topView.frame;
//        frame.size.height = TopViewH + downDistance;
//        self.topView.frame = frame;
        self.topView.transform = CGAffineTransformMakeScale(1 + downDistance * 0.005, 1 + downDistance * 0.005); // 0.005 -> 放大系数
    }

}

@end
