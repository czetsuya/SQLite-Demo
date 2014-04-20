//
//  KBSSqliteConnection.h
//  SqliteAnimeDb
//
//  Created by czetsuya on 4/20/14.
//  Copyright (c) 2014 Kalidad Business Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface KBSSqliteConnection : NSObject

@property sqlite3 *db;
@property BOOL open;

- (BOOL)createTable;
- (BOOL)openDb;
- (BOOL)insertAnime:(NSString *) title :(NSString *) author;
- (void)close;
- (BOOL)clear;

@end
