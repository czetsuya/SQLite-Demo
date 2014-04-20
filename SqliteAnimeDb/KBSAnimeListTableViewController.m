//
//  KBSAnimeListTableViewController.m
//  SqliteAnimeDb
//
//  Created by czetsuya on 4/20/14.
//  Copyright (c) 2014 Kalidad Business Solutions. All rights reserved.
//

#import "KBSAnimeListTableViewController.h"
#import "KBSSqliteConnection.h"

@interface KBSAnimeListTableViewController ()

@property KBSSqliteConnection *conn;

@end

@implementation KBSAnimeListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view.load");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //open database
    self.conn = [[KBSSqliteConnection alloc] init];
    [self fetchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_animeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"animeCell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    KBSAnime *anime = [_animeList objectAtIndex:indexPath.row];
    cell.textLabel.text = anime.title;
    cell.detailTextLabel.text = anime.author;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fetchTable:(id)sender
{
    [self fetchData];
    [self.tableView reloadData];
}

-(void)fetchData
{
    if([self.conn openDb]) {
        self.conn.open = YES;
        // load data
        _animeList = [[NSMutableArray alloc] init];
        NSString *fetchSql = @"SELECT * FROM anime";
        
        NSLog(@"sql=%@", fetchSql);
        
        _animeList = [[NSMutableArray alloc] init];
        
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(_conn.db, [fetchSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while(sqlite3_step(statement) == SQLITE_ROW) {
                KBSAnime *anime = [[KBSAnime alloc] init];
                
                char *titleField = (char *)sqlite3_column_text(statement, 1);
                anime.title = [[NSString alloc] initWithUTF8String:titleField];
                char *authorField = (char *)sqlite3_column_text(statement, 2);
                anime.author = [[NSString alloc] initWithUTF8String:authorField];
                
                [_animeList addObject:anime];
            }
        }
        [_conn close];
    }
}

- (IBAction)clearDb:(id)sender
{
    if(!_conn.open) {
        [_conn openDb];
    }
    
    [_conn clear];
    
    [_conn close];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Database has been successfully cleared. Click reload data to refresh the table" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [av show];
}

@end