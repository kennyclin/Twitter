//
//  Tweet.m
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

-(id)initWithDictionary:(NSDictionary*) dictionary{
    self = [super init];
    if (self){
        self.id = dictionary[@"id_str"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.retweetNo = [dictionary[@"retweet_count"] intValue];
        self.favoriteNo = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        if (dictionary[@"retweeted_status"]) {
            self.retweetedTweet = [[Tweet alloc] initWithDictionary:dictionary[@"retweeted_status"]];
        }
       // NSLog(@"favorite count: %@", dictionary[@"favorite_count"]);
    }
    return self;
}

+(NSArray*) tweetsWithArray:(NSArray*) array {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dic in array){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dic];
        [result addObject:tweet];
    }
    return result;
}

-(NSString*) getDisplayTime{
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval since = [now timeIntervalSinceDate:self.createdAt];
    int hours = (int) since/3600;
    if (hours>24){
        NSDateFormatter *ymd = [[NSDateFormatter alloc] init];
        ymd.dateFormat = @"M/d/yy";
        return [ymd stringFromDate:self.createdAt];
    } else return [NSString stringWithFormat:@"%dh", hours];
    
}

@end
