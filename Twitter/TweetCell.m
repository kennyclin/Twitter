//
//  TweetCell.m
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "TwitterClient.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageURL;
@property (weak, nonatomic) IBOutlet UILabel *retweetedBy;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAlias;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favImageView;

/*
@property (weak, nonatomic) IBOutlet UIImageView *profileImageURL;

@property (weak, nonatomic) IBOutlet UILabel *retweetedBy;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAlias;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@property (weak, nonatomic) IBOutlet UILabel *text;
*/

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *favTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favDetected)];
    favTap.numberOfTapsRequired=1;
    [self.favImageView setUserInteractionEnabled:YES];
    [self.favImageView addGestureRecognizer:favTap];
    
    UITapGestureRecognizer *retweetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetDetected)];
    retweetTap.numberOfTapsRequired=1;
    [self.retweetImageView setUserInteractionEnabled:YES];
    [self.retweetImageView addGestureRecognizer:retweetTap];
    
    UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileDetected)];
    profileTap.numberOfTapsRequired=1;
    [self.profileImageURL setUserInteractionEnabled:YES];
    [self.profileImageURL addGestureRecognizer:profileTap];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) favDetected {
    NSLog(@"favorite tapped!!! id: %@", _tweetModel.id);
    [[TwitterClient sharedInstance] setFavorite:_tweetModel.id completion:^(NSError *error) {
        if (error != NULL){
            _tweetModel.favorited=YES;
            [self setTweetModel:_tweetModel];
        } else {
            NSLog(@"failed to set favorite %@", error);
        }
    }];
}

- (void) profileDetected {
    NSLog(@"profile image tapped! %@", _tweetModel.user);
    [self.delegate onProfile:_tweetModel.user];
}

-(void) retweetDetected {
    [[TwitterClient sharedInstance] retweet:_tweetModel.id completion:^(NSError *error) {
        if (error != NULL){
            NSLog(@"retweeted!");
        }
    }];
}

- (void) setTweetModel:(Tweet *)tweetModel {
    _tweetModel=tweetModel;
    User *user=self.tweetModel.user;
    [self.profileImageURL setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.retweetedBy.text=@"";
    self.userName.text=user.name;
    self.userAlias.text=[NSString stringWithFormat:@"@%@", user.screenname];
    self.createTime.text=[tweetModel getDisplayTime];
    self.text.text=tweetModel.text;
    if (tweetModel.favorited){
        self.favImageView.image = [UIImage imageNamed:@"twitter-favon-icon"];
    } else {
        self.favImageView.image = [UIImage imageNamed:@"star_fav"];
    }
    
}



@end
