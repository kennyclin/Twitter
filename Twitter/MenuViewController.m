//
//  MenuViewController.m
//  Twitter
//
//  Created by Kenny Lin on 7/6/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "MenuViewController.h"
#import "ProfileViewController.h"
#import "TweetViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYConstraint;

@property (strong, nonatomic) UIViewController *currentVC;
@property (strong, nonatomic) ProfileViewController *profileVC;
@property (strong, nonatomic) TweetViewController *tweetsVC;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // Profile View
    self.profileVC = [[ProfileViewController alloc] init];
    //UINavigationController *pnvc = [[UINavigationController alloc] initWithRootViewController:self.profileVC];
   /*pnvc.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    pnvc.navigationBar.tintColor = [UIColor whiteColor];
    [pnvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    pnvc.navigationBar.translucent = NO;
   */
    // set self as delage for pull downs
    //pvc.delegate = self;
    
    // Timeline
    self.tweetsVC = [[TweetViewController alloc] init];
    /*
    UINavigationController *tnvc = [[UINavigationController alloc] initWithRootViewController:tvc];
    tnvc.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    tnvc.navigationBar.tintColor = [UIColor whiteColor];
    [tnvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    tnvc.navigationBar.translucent = NO;
    */
    
    // Mentions
    /*
    MentionsViewController *mvc = [[MentionsViewController alloc] init];
    UINavigationController *mnvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    mnvc.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    mnvc.navigationBar.tintColor = [UIColor whiteColor];
    [mnvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    mnvc.navigationBar.translucent = NO;
    */
    
    // set profile as initial view
    self.currentVC = self.tweetsVC; // fixed me
    self.currentVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.currentVC.view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row){
        case 0:
            self.currentVC = self.profileVC;
            break;
        case 1:
            self.currentVC = self.tweetsVC;
            break;
        case 2:
            break;
    }
    [self setContentController];
    
}

/*
- (void) moveViewInX:(UIView *) view (float) xmove {
    CGRect theFrame = view.frame;
    float newX = theFrame.origin.x + xmove;
    self scrollT
    
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.bounds.size.height / 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Profile";
            break;
        case 1:
            cell.textLabel.text = @"Timeline";
            break;
        case 2:
            cell.textLabel.text = @"Mentions";
            break;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21];
    cell.textLabel.textColor = [UIColor whiteColor];
    // use twitter color https://about.twitter.com/press/brand-assets
    cell.backgroundColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    
    return cell;
}

- (IBAction)didSwipeRight:(id)sender {
    NSLog(@"Swipe right detected");
    // reload data to handle height change since row heights are based on table height
    [self.tableView reloadData];
    [UIView animateWithDuration:.24 animations:^{
        self.centerXConstraint.constant = -200;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)didSwipeLeft:(id)sender {
    NSLog(@"Swipe left detected");
    [UIView animateWithDuration:.24 animations:^{
        self.centerXConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)setContentController {
    self.currentVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.currentVC.view];
    [self.currentVC didMoveToParentViewController:self];
    
    [UIView animateWithDuration:.24 animations:^{
        self.centerXConstraint.constant = 0;
        self.centerYConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
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
