//
//  NewTweetController.m
//  Twitter
//
//  Created by Kenny Lin on 7/1/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "NewTweetController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "TwitterClient.h"
#import "TweetViewController.h"

int const MAX_LETTER = 140;

@interface NewTweetController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) UIBarButtonItem *submit;
//@property (strong, nonatomic) UILabel *wordCountLabel;
@property (strong, nonatomic) UIBarButtonItem *wordCount;


@end

@implementation NewTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    User *currentUser = [User currentUser];
    [self.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.nameLabel.text = currentUser.name;
    self.aliasLabel.text = [NSString stringWithFormat:@"@%@", currentUser.screenname];
    self.submit = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(doSubmit)];
    
   /* self.wordCountLabel = [[UILabel alloc] init];
    self.wordCountLabel.text = [NSString stringWithFormat:@"%d", MAX_LETTER];
    [self.wordCountLabel  setTextColor: [UIColor whiteColor]];
    self.wordCountLabel.alpha = 0.5;
    */
    //UIBarButtonItem *labelItem= [[UIBarButtonItem alloc] initWithCustomView:self.wordCountLabel];
    self.wordCount=[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", MAX_LETTER ] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    NSMutableArray *buttonArray=[[NSMutableArray alloc] init];
    [buttonArray addObject:self.submit];
    
    [buttonArray addObject:self.wordCount];
    
    [self.navigationItem setRightBarButtonItems:buttonArray];
    self.tweetModel = [[Tweet alloc] init];
    self.tweetTextView.delegate = self;
    
}
-(void) doSubmit {
    NSLog(@"about to update twitter status (post new tweet)");
    self.tweetModel.text = self.tweetTextView.text;
    [[TwitterClient sharedInstance] updateStatus:self.tweetModel completion:^(NSError *error) {
        if (error != nil){
            NSLog(@"Update status failed! %@", error);
        } else {
            [self.navigationController pushViewController:[[TweetViewController alloc] init] animated:YES];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"current input size: %d", textView.text.length);
    int currentLeft=MAX_LETTER-textView.text.length;
    NSLog(@"letter left: %d", currentLeft);
    self.wordCount.title = [NSString stringWithFormat:@"%d", currentLeft];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
