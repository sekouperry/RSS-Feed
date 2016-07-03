//
//  FeedModuleFeedModuleViewController.m
//  RSS-Feed
//
//  Created by Igor Vasilenko on 02/07/2016.
//  Copyright © 2016 Igor Vasilenko. All rights reserved.
//

#import "FeedModuleViewController.h"

#import "FeedModuleViewOutput.h"
#import "FeedDataDisplayManager.h"
#import "SVProgressHUD.h"

@implementation FeedModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы FeedModuleViewInput

- (void)setupInitialState
{
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self.output
							action:@selector(didTriggerPullToRefreshEvent)
				  forControlEvents:UIControlEventValueChanged];

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[SVProgressHUD showWithStatus:@"Loading feed"];

	self.tableView.delegate = [self.feedDataDisplayManager delegateForTableView:self.tableView
														  baseTableViewDelegate:nil];
}

- (void)updateStateWithFeed:(NSArray <ItemInfoModel *> *)feed
{
	[self.feedDataDisplayManager configureDataDisplayManagerWithFeed:feed];

	self.tableView.dataSource = [self.feedDataDisplayManager dataSourceForTableView:self.tableView];
}

- (void)initiateStartRefreshingFeedState
{
	[SVProgressHUD showWithStatus:@"Loading feed"];
}

- (void)stopRefreshingFeedState
{
	[self.refreshControl endRefreshing];
	[SVProgressHUD dismiss];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
																			 message:message
																	  preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
														  style:UIAlertActionStyleDefault
														handler:NULL];
	[alertController addAction:alertAction];

	[self presentViewController:alertController
					   animated:YES
					 completion:NULL];
}

@end
