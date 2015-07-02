//
//  TweetViewController.m
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "TweetViewController.h"
#import "User.h"
#import "TweetCell.h"
#import "TwitterClient.h"
#import "NewTweetController.h"
#import "TweetDetailViewController.h"

@interface TweetViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *signOutButton;
@property (strong, nonatomic) UIBarButtonItem *myTweetButton;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *homeTweets;

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    [self.navigationItem setTitle:@"Home"];
    
    
    self.signOutButton=[[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(doLogout)];
    self.myTweetButton=[[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(myNewTweet)];
    
    [self.navigationItem setLeftBarButtonItem:self.signOutButton];
    [self.navigationItem setRightBarButtonItem:self.myTweetButton];
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDon/e target:nil action:nil];
    
    [self refreshRemoteData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

        
}

-(void) doLogout {
    [User logout];
}

-(void) myNewTweet {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:cancelButton];
    [self.navigationController pushViewController:[[NewTweetController alloc] init] animated:YES];
}

-(void) refreshRemoteData {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (tweets!=nil){
            self.homeTweets=tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"error : %@", error);
        }
        
    }];
}

-(void) onRefresh {
    [self refreshRemoteData];
    [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogout:(id)sender {
    NSLog(@"about to logout!!!");
    [User logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweetModel= self.homeTweets[indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    vc.tweetModel = self.homeTweets[indexPath.row];
    [self.navigationItem.backBarButtonItem setTitle:@"Home"];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
