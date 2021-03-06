//
//  User.m
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property (strong, nonatomic) NSDictionary* dictionary;

@end

@implementation User

-(id)initWithDictionary:(NSDictionary *) dictionary{
    self=[super init];
    if (self){
        self.dictionary = dictionary;
        self.name=dictionary[@"name"];
        self.screenname=dictionary[@"screen_name"];
        self.profileImageUrl=dictionary[@"profile_image_url"];
        self.tagline=dictionary[@"description"];
        self.backgroundImageUrl = dictionary[@"profile_background_image_url"];
        self.tweetNo = [dictionary[@"statuses_count"] integerValue];
        self.followingNo = [dictionary[@"friends_count"] integerValue];
        self.followerNo = [dictionary[@"followers_count"] integerValue];
        self.bannerUrl = dictionary[@"profile_banner_url"];
        
    }
    return self;
}

static User* _currentUser=nil;
NSString * const kCurrentUserKey = @"kCurrentUserKey";

+(User *) currentUser{
    if (_currentUser == nil){
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil){
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+(void) setCurrentUser:(User *)user {
    _currentUser=user;
    if (_currentUser != nil){
        NSData *data = [NSJSONSerialization dataWithJSONObject:_currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) logout{
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
    
}

@end

