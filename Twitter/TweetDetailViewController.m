//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Kenny Lin on 7/1/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetNoLabel;

@property (weak, nonatomic) IBOutlet UILabel *favoriteNoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favImageView;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Now here");
    [self setTweetModel:self.tweetModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTweetModel:(Tweet *)tweetModel {
    _tweetModel=tweetModel;
    User *user=self.tweetModel.user;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.nameLabel.text=user.name;
    self.aliasLabel.text=[NSString stringWithFormat:@"@%@", user.screenname];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    self.tweetTimeLabel.text = [formatter stringFromDate:tweetModel.createdAt];
    self.textLabel.text=tweetModel.text;
    self.tweetNoLabel.text=[NSString stringWithFormat:@"%d", tweetModel.retweetNo];
    self.favoriteNoLabel.text=[NSString stringWithFormat:@"%d", tweetModel.favoriteNo];
    
    
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
