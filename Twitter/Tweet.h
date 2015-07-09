//
//  Tweet.h
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSDate* createdAt;
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) NSString* id;
@property (assign, nonatomic) int retweetNo;
@property (assign, nonatomic) int favoriteNo;
@property (assign, nonatomic) BOOL favorited;
@property (strong, nonatomic) Tweet* retweetedTweet;

-(id)initWithDictionary:(NSDictionary*) dictionary;
+(NSArray*) tweetsWithArray:(NSArray*) array;
-(NSString*) getDisplayTime;

@end
