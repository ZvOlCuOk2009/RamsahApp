//
//  DataArray.m
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "DataArray.h"
#import "dataModel.h"

@implementation DataArray

@synthesize arrMainMenus;
@synthesize arrWordLists;
@synthesize arrSubMenus;
@synthesize arrRamsahs;
@synthesize dbHandler;
@synthesize arrSigns;
@synthesize strWebSiteLink;

+ (BOOL)createTable:(sqlite3 *)dbHandler {
	NSString* strQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@ VARCHAR(%d) NOT NULL, %@ VARCHAR(%d) NOT NULL, %@ VARCHAR(%d) NOT NULL, %@ VARCHAR(%d) NOT NULL)", TABLE_NAME, FIELD_SUB_ID, 9, FIELD_WORD_ID, 9, FIELD_IS, 5, FIELD_SAVED, 5];
    
	if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
		return NO;
	
	return YES;
}

-(id)initWithDBHandler:(sqlite3*)_dbHandler {
	self = [super init];
	
	if (self) {
		self.dbHandler = _dbHandler;

	}
	return self;
}

-(void)insertFavouriteInformation{
    NSLog(@"%lu", (unsigned long)[arrWordLists count]);
    for (int i = 0; i < [arrWordLists count]; i ++){
        WordRecord* wordRecord = [[WordRecord alloc]init];
        wordRecord = [arrWordLists objectAtIndex:i];
        
        if (![self is_registered:wordRecord.intSubId wordId:wordRecord.intWordId]){
            [self insertNewWord:wordRecord.intSubId wordId:wordRecord.intWordId];
        }
    }
}

-(BOOL)is_registered:(int)intSubId wordId:(int)intWordId{
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%d' and %@ = '%d'", TABLE_NAME, FIELD_SUB_ID, intSubId, FIELD_WORD_ID, intWordId];
    sqlite3_stmt* stmt;
    
    int rows = 0;
    
    if (sqlite3_prepare_v2(dbHandler, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            rows++;
        }
    }
    
    if (rows == 0)return FALSE;
    return YES;
}

-(BOOL)isFavourite:(int)intSubId wordId:(int)intWordId{
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%d' AND %@ = '%d' AND %@='true'", TABLE_NAME, FIELD_SUB_ID, intSubId, FIELD_WORD_ID, intWordId, FIELD_IS];
    sqlite3_stmt* stmt;
    
    int rows = 0;
    
    if (sqlite3_prepare_v2(dbHandler, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            rows++;
        }
    }
    
    if (rows == 0)return FALSE;
    return YES;
}

-(BOOL)isSaved:(int)intSubId wordId:(int)intWordId{
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%d' AND %@ = '%d' AND %@='true'", TABLE_NAME, FIELD_SUB_ID, intSubId, FIELD_WORD_ID, intWordId, FIELD_SAVED];
    sqlite3_stmt* stmt;
    
    int rows = 0;
    
    if (sqlite3_prepare_v2(dbHandler, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            rows++;
        }
    }
    
    if (rows == 0)return FALSE;
    return YES;
}

-(void)insertNewWord:(int)intSubId wordId:(int)intWordId{
    NSString* sql = [NSString stringWithFormat:@"insert into %@ values('%d', '%d', 'false', 'false')", TABLE_NAME, intSubId, intWordId];
    sqlite3_exec(dbHandler, [sql UTF8String], NULL, NULL, NULL);
}

-(BOOL)setFavouriteItem:(int)intSubId wordId:(int)intWordId value:(NSString*)value{
    NSString* sql = [NSString stringWithFormat:@"update %@ set %@='%@' where %@='%d' and %@='%d'", TABLE_NAME, FIELD_IS, value, FIELD_SUB_ID, intSubId, FIELD_WORD_ID, intWordId];
    
    char *erroMsg;
    if (sqlite3_exec(dbHandler, [sql UTF8String], NULL, NULL, &erroMsg) == SQLITE_OK){
        return TRUE;
    }
    return FALSE;
}

-(BOOL)setSavedItem:(int)intSubId wordId:(int)intWordId value:(NSString*)value{
    NSString* sql = [NSString stringWithFormat:@"update %@ set %@='%@' where %@='%d' and %@='%d'", TABLE_NAME, FIELD_SAVED, value, FIELD_SUB_ID, intSubId, FIELD_WORD_ID, intWordId];
    
    char *erroMsg;
    if (sqlite3_exec(dbHandler, [sql UTF8String], NULL, NULL, &erroMsg) == SQLITE_OK){
        return TRUE;
    }
    return FALSE;
}

-(void)alert:(NSString*)titleString content:(NSString*)contentString{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleString message:contentString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)multiAlert:(NSString*)titleString content:(NSString*)contentString{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleString message:contentString delegate:self cancelButtonTitle:@"No/مب غايته" otherButtonTitles:@"Yes/هيه", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strWebSiteLink]];
    }
}

@end
