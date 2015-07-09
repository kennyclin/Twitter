//
//  ProfileViewController.m
//  Twitter
//
//  Created by Kenny Lin on 7/6/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "ProfileViewController.h"
#import "TweetDetailViewController.h"
#import "ProfileHeaderCell.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    User *user = self.user ? self.user : [User currentUser];
    
    // profile view via profile image
    if (!self.user) {
        // add Sign Out button
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        // set up title with long press gesture recognizer
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 300, 40)];
        navLabel.text = user.name;
        navLabel.textAlignment = NSTextAlignmentCenter;
        navLabel.textColor = [UIColor whiteColor];
        navLabel.font = [UIFont boldSystemFontOfSize:17.0f];    // default font for consistency
        [navLabel setUserInteractionEnabled:YES];
        self.navigationItem.titleView = navLabel;
        
       // UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onNavBarLongPress)];
        
        //[navLabel addGestureRecognizer:longPressGestureRecognizer];
    } else {
        self.navigationItem.title = user.name;
    }
    
    // use banner url if provided, or profile bg url
    NSString *bannerUrl = user.bannerUrl ? [NSString stringWithFormat:@"%@/mobile_retina", user.bannerUrl] : user.backgroundImageUrl;
    [self.bgImageView setImageWithURL:[NSURL URLWithString:bannerUrl]];
    
    
    // register profile cell nib
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileHeaderCell" bundle:nil] forCellReuseIdentifier:@"ProfileHeaderCell"];
    
    // register tweet cell nib
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 105;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (user) {
        [self refreshProfile];
    }

}

- (void)onLogout {
    [User logout];
}

- (void)refreshProfile {
    NSLog(@"entering refresh profile");
    [[TwitterClient sharedInstance] userTimelineWithParams:nil user:self.user completion:^(NSArray *tweets, NSError *error) {
        NSLog(@"function returned...");
        if (error) {
            NSLog(@"Error getting user timeline, too many requests?: %@", error);
        } else {
            self.tweets = tweets;
            [self.tableView reloadData];
        }
        /*
        [self.loadingIndicator hide:YES];
        [self.refreshTweetsControl endRefreshing];
        [self.bgView setHidden:NO];
        [self.tableView setHidden:NO];
         */
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // unhighlight selection
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // do nothing if profile cell
    if (indexPath.row == 0) {
        return;
    }
    
    TweetDetailViewController *tdvc = [[TweetDetailViewController alloc] init];
    //vc.delegate = self;
    tdvc.tweetModel = self.tweets[indexPath.row - 1];
    [self.navigationController pushViewController:tdvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0){
        return 202;
    } else {
        return 100;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        ProfileHeaderCell *profileCell = [tableView dequeueReusableCellWithIdentifier:@"ProfileHeaderCell"];
        User *user;
        
        if (self.user) {
            user = self.user;
        } else {
            user = [User currentUser];
        }
        
        [profileCell setUser:user];
        
        return profileCell;
    } else {
        TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
        tweetCell.tweetModel = self.tweets[indexPath.row - 1];
        tweetCell.delegate = self;
        
        return tweetCell;
    }
}

- (void)onProfile:(User *)user {
    ProfileViewController *pvc = [[ProfileViewController alloc] init];
    [pvc setUser:user];
    [self.navigationController pushViewController:pvc animated:YES];
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
