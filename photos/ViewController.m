//
//  ViewController.m
//  photos
//
//  Created by Aaron Alexander on 7/1/15.
//  Copyright (c) 2015 speakeasy. All rights reserved.
//

#import "ViewController.h"
#import "SEConstants.h"
#import "PopularPhotosCall.h"
#import "AppData.h"
#import "Photo.h"
#import "PhotoTimelineCell.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UITableView *photosFeedTable;
@property(weak, nonatomic) IBOutlet UIView *navBarView;
@property(nonatomic) NSArray *currentPopularPhotos;
@property(nonatomic) UIRefreshControl *refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setupTableView];
    [self setupDoubleTapNavBar];
    [self getNewPhotosFromServer];
}
#pragma mark - View Setup
- (void)setupTableView
{
    self.photosFeedTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.photosFeedTable.estimatedRowHeight = 500.0f;
    self.photosFeedTable.rowHeight = UITableViewAutomaticDimension;
    UINib *nib = [UINib nibWithNibName:@"PhotoTimelineCell" bundle:nil];
    [self.photosFeedTable registerNib:nib forCellReuseIdentifier:@"PhotoTimelineCell"];
    [self addPullToRefresh];
}

- (void)addPullToRefresh
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.9753 green:0.9753 blue:0.9753 alpha:1.0];
    self.refreshControl.tintColor = [UIColor colorWithRed:0.0745 green:0.6157 blue:0.9176 alpha:1.0];
    [self.refreshControl addTarget:self action:@selector(getNewPhotosFromServer) forControlEvents:UIControlEventValueChanged];
    [self.photosFeedTable addSubview:self.refreshControl];
}
- (void)setupDoubleTapNavBar
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTapNavBar)];
    doubleTap.numberOfTapsRequired = 2;
    [self.navBarView addGestureRecognizer:doubleTap];
}
- (void)reloadItemsAndTable
{
    self.currentPopularPhotos = [AppData sharedInstance].currentPhotosArray;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.photosFeedTable reloadData];
      [self.refreshControl endRefreshing];
    });
}
- (void)doDoubleTapNavBar
{
    [self.photosFeedTable setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Server Calls
- (void)getNewPhotosFromServer
{
    PopularPhotosCall *photosCall = [[PopularPhotosCall alloc] init];
    __weak typeof(self) weakSelf = self;
    [photosCall getPopularPhotos:^(BOOL success, NSString *errorString) {
      if (success) {
          NSLog(@"Call Complete");
          [weakSelf reloadItemsAndTable];
      } else {
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
          [alert show];
      }

    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = self.currentPopularPhotos.count;

    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellIdentifier = @"PhotoTimelineCell";
    PhotoTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row < self.currentPopularPhotos.count) {
        Photo *tempPhotoData = self.currentPopularPhotos[indexPath.row];
        [cell loadDataFromPhoto:tempPhotoData];
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableHeaderView = [[UIView alloc] init];

    return tableHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
@end
