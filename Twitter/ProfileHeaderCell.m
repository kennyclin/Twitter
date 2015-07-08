//
//  ProfileHeaderCell.m
//  Twitter
//
//  Created by Kenny Lin on 7/6/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "ProfileHeaderCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileHeaderCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerLabel;

@end

@implementation ProfileHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(User *)user {
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    
    self.nameLabel.text = user.name;
    self.aliasLabel.text = [NSString stringWithFormat:@"@%@", user.screenname];
    
    
    // use friendly numbers like twitter
    self.tweetNoLabel.text =  [NSString stringWithFormat:@"%d", user.tweetNo ];
    self.followingLabel.text = [NSString stringWithFormat:@"%d", user.followingNo];
    self.followerLabel.text = [NSString stringWithFormat:@"%d", user.followerNo];
    
}

@end
