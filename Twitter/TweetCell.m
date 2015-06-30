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

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageURL;
@property (weak, nonatomic) IBOutlet UILabel *retweetedBy;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAlias;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *text;

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweetModel:(Tweet *)tweetModel {
    _tweetModel=tweetModel;
    User *user=self.tweetModel.user;
    [self.profileImageURL setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.retweetedBy.text=@"";
    self.userName.text=user.name;
    self.userAlias.text=[NSString stringWithFormat:@"#%@", user.screenname];
    self.createTime.text=@"14h";
    self.text.text=tweetModel.text;
    
    
}

@end
