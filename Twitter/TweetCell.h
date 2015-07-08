//
//  TweetCell.h
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

- (void)onProfile:(User *)user;

@end

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) Tweet *tweetModel;
@property (weak, nonatomic) id<TweetCellDelegate> delegate;

@end
