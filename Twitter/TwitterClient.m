//
//  TwitterClient.m
//  Twitter
//
//  Created by Kenny Lin on 6/30/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//


#import "TwitterClient.h"
#import "Tweet.h"

NSString const *TwitterConsumerKey=@"cMp9RC2yAoTU6egSQ1WFVq4XI";
NSString const *TwitterConsumerSecret=@"ekKCJYrWSin2ZiEiK7Dagnggz0fxg8Ps3BwcfinCdUx7vFqzkp";
NSString const *TwitterBaseURL=@"https://api.twitter.com";

@interface TwitterClient()

@property (strong, nonatomic) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *tClient=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tClient==nil){
            tClient=[[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:TwitterBaseURL] consumerKey:TwitterConsumerKey consumerSecret:TwitterConsumerSecret];
        }
    });
    return tClient;
}

-(void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"got the request token!");
        
        // send user to authenticate
        NSURL *authURL=[NSURL URLWithString:[NSString stringWithFormat: @"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];  // open safari
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token!");
        self.loginCompletion(nil, error);
    }];
    
}

-(void) openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query]  success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got the access token!");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"current user: %@", responseObject);
            User *user=[[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"current user name: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to get current user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token!");
        self.loginCompletion(nil, error);
    }];
    
}

-(void) homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"json object: %@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        NSLog(@"tweets got count: %d", tweets.count);
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) updateStatus:(Tweet *) tweet completion:(void (^) (NSError* error)) completion {
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:tweet.text forKey:@"status"];
    [self POST:@"1.1/statuses/update.json" parameters:dict constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completion(nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            completion(error);
        }];
}

- (void) retweet:(NSString *) idStr completion:(void (^) (NSError* error)) completion{
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", idStr];
    [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"retweet done!");
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to retweet!");
        completion(error);
    }];
}

- (void) setFavorite:(NSString *) idStr completion:(void (^) (NSError* error)) completion{
    NSString *url = [NSString stringWithFormat:@"1.1/favorites/create.json?id=%@", idStr];
    [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"favorite set!");
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to retweet!");
        completion(error);
    }];
}

- (void) reply:(Tweet *) tweet completion:(void (^) (NSError* error)) completion{
    completion(nil);
}

@end
