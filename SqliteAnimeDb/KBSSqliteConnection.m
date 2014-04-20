//
//  KBSSqliteConnection.m
//  SqliteAnimeDb
//
//  Created by czetsuya on 4/20/14.
//  Copyright (c) 2014 Kalidad Business Solutions. All rights reserved.
//

#import "KBSSqliteConnection.h"

@implementation KBSSqliteConnection

#pragma Create Sql Tables
- (BOOL)createTable
{
    NSLog(@"creating table");
    BOOL result = NO;
    char *err;
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS 'anime' (ID INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT);";
    
    NSLog(@"SQL: %@", sql);
    
    if(sqlite3_exec(self.db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(self.db);
        NSLog(@"KO");
    } else {
        NSLog(@"OK");
        result = YES;
    }
    
    return result;
}

- (BOOL)openDb
{
    BOOL result = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *sqlFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"anime"];
    if(sqlite3_open([sqlFile UTF8String], &_db) == SQLITE_OK) {
        result = YES;
    }
    
    return result;
}

- (BOOL)insertAnime:(NSString *) title :(NSString *) author;
{
    BOOL result = NO;
    NSLog(@"inserting record...");
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO anime (title, author) values ('%@', '%@')", title, author];
    
    NSLog(@"sql=%@", sqlInsert);
    
    char *err;
    if(sqlite3_exec(self.db, [sqlInsert UTF8String], NULL, NULL, &err) == SQLITE_OK) {
        sqlite3_close(self.db);
        NSLog(@"OK");
    } else {
        NSLog(@"KO");
    }
    
    return result;
}

- (void)close
{
    sqlite3_close(self.db);
    self.open = NO;
}

- (BOOL)clear
{
    NSLog(@"clearing table");
    BOOL result = NO;
    char *err;
    
    NSString *sql = @"DELETE FROM anime";
    
    NSLog(@"SQL: %@", sql);
    
    if(sqlite3_exec(self.db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(self.db);
        NSLog(@"KO");
    } else {
        NSLog(@"OK");
        result = YES;
    }
    
    return result;
}

@end
