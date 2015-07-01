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

@interface TweetViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *signOutButton;
@property (strong, nonatomic) UIBarButtonItem *myTweetButton;

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (tweets!=nil){
            self.homeTweets=tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"error : %@", error);
        }
        
    }];
        
}

-(void) doLogout {
    [User logout];
}

-(void) myNewTweet {
    [self.navigationController pushViewController:[[NewTweetController alloc] init] animated:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end