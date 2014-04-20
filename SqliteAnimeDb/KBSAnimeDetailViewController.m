//
//  KBSAnimeDetailViewController.m
//  SqliteAnimeDb
//
//  Created by czetsuya on 4/20/14.
//  Copyright (c) 2014 Kalidad Business Solutions. All rights reserved.
//

#import "KBSAnimeDetailViewController.h"
#import "KBSAnime.h"
#import "KBSSqliteConnection.h"

@interface KBSAnimeDetailViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *animeTitle;
@property (weak, nonatomic) IBOutlet UITextField *animeAuthor;

@property KBSSqliteConnection *conn;

@end

@implementation KBSAnimeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //open database
    self.conn = [[KBSSqliteConnection alloc] init];
    if([self.conn openDb]) {
        self.conn.open = YES;
        [self.conn createTable];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClick:(id)sender
{
    NSLog(@"addClick");
    
    // insert to database
    if(self.animeTitle.text.length > 0 && self.animeAuthor.text.length > 0) {
        if([self.conn open]) {
            //save
            [self.conn insertAnime:self.animeTitle.text :self.animeAuthor.text];
            self.animeTitle.text = @"";
            self.animeAuthor.text = @"";
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if(sender == self.doneButton && self.animeTitle.text.length > 0 && self.animeAuthor.text.length > 0) {
//        KBSAnime *anime = [[KBSAnime alloc] init];
//        anime.title = self.animeTitle.text;
//        anime.author = self.animeAuthor.text;
//    }
    NSLog(@"prepareForSeque");
}



@end
