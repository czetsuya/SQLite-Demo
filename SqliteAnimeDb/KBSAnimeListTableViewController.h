//
//  KBSAnimeListTableViewController.h
//  SqliteAnimeDb
//
//  Created by czetsuya on 4/20/14.
//  Copyright (c) 2014 Kalidad Business Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "KBSAnime.h"

@interface KBSAnimeListTableViewController : UITableViewController

@property KBSAnime *anime;
@property sqlite3 *animeDb;
@property NSMutableArray *animeList;

@end
