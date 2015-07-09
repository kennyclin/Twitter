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
#import <UIKit/UIKit.h>

@interface MenuViewController () 
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYConstraint;

@property (strong, nonatomic) UIViewController *currentVC;
@property (strong, nonatomic) ProfileViewController *profileVC;
@property (strong, nonatomic) UINavigationController *profileNC;
@property (strong, nonatomic) TweetViewController *tweetsVC;
@property (strong, nonatomic) UINavigationController *tweetsNC;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRightGR;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftGR;


@end

@implementation MenuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // Profile View
    self.profileVC = [[ProfileViewController alloc] init];
    self.profileNC = [[UINavigationController alloc] initWithRootViewController:self.profileVC];
    self.profileNC.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    self.profileNC.navigationBar.tintColor = [UIColor whiteColor];
    [self.profileNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.profileNC.navigationBar.translucent = NO;
   
    // set self as delage for pull downs
    //pvc.delegate = self;
    
    // Timeline
    self.tweetsVC = [[TweetViewController alloc] init];
    
    self.tweetsNC = [[UINavigationController alloc] initWithRootViewController:self.tweetsVC];
    self.tweetsNC.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    self.tweetsNC.navigationBar.tintColor = [UIColor whiteColor];
    [self.tweetsNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.tweetsNC.navigationBar.translucent = NO;
    
    
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
    self.currentVC = self.tweetsNC; // fixed me
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
            self.currentVC = self.profileNC;
            break;
        case 1:
            self.currentVC = self.tweetsNC;
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
    cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x,
                                      cell.imageView.frame.origin.y,
                                      80, 80);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.clipsToBounds = YES;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"profile-icon"];
            //cell.textLabel.text = @"Profile";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"timeline-icon"];
           // cell.textLabel.text = @"Timeline";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"mentions-icon"];
            //cell.textLabel.text = @"Mentions";
            break;
    }
    
    //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
   // cell.textLabel.textColor = [UIColor whiteColor];
    // use twitter color https://about.twitter.com/press/brand-assets
    cell.backgroundColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    
    return cell;
}

- (IBAction)didSwipeRight:(id)sender {
    NSLog(@"Swipe right detected");
    // reload data to handle height change since row heights are based on table height
    [self.tableView reloadData];
    [UIView animateWithDuration:.24 animations:^{
        self.centerXConstraint.constant = -60;
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
