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
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
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

@end
