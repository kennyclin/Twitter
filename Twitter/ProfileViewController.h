//
//  ProfileViewController.h
//  Twitter
//
//  Created by Kenny Lin on 7/6/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "User.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (strong, nonatomic) User *user;

@end
