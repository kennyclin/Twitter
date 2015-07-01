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

@interface NewTweetController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) UIBarButtonItem *submit;
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
   self.wordCount = [[UIBarButtonItem alloc] initWithTitle:@"140" style:UIBarButtonItemStylePlain target:nil action:nil];
   // self.wordCount = [[UILabel alloc] init];
    //[self.wordCount setText:@"140"];
   // self.wordCount .alpha=0.5;
    
    NSMutableArray *buttonArray=[[NSMutableArray alloc] init];
    [buttonArray addObject:self.submit];
    [buttonArray addObject:self.wordCount];
    
    [self.navigationItem setRightBarButtonItems:buttonArray];

    
    
}
-(void) doSubmit {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
