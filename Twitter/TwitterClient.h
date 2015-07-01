//
//  TwitterClient.h
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void) openURL:(NSURL *) url;

- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^) (NSArray* tweets, NSError* error)) completion;
- (void) updateStatus:(Tweet *) tweet completion:(void (^) (NSError* error)) completion;
- (void) retweet:(NSString *) idStr completion:(void (^) (NSError* error)) completion;
- (void) setFavorite:(NSString *) idStr completion:(void (^) (NSError* error)) completion;
- (void) reply:(Tweet *) tweet completion:(void (^) (NSError* error)) completion;

@end
