//
//  User.h
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification ;
extern NSString * const UserDidLogoutNotification ;

@interface User : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* screenname;
@property (strong, nonatomic) NSString* profileImageUrl;
@property (strong, nonatomic) NSString* backgroundImageUrl;
@property (strong, nonatomic) NSString* bannerUrl;
@property (strong, nonatomic) NSString* tagline;
@property (assign, nonatomic) NSInteger tweetNo;
@property (assign, nonatomic) NSInteger followingNo;
@property (assign, nonatomic) NSInteger followerNo;


-(id)initWithDictionary:(NSDictionary *) dictionary;
+(User *) currentUser;
+(void) setCurrentUser:(User*) user;
+(void) logout;

@end

