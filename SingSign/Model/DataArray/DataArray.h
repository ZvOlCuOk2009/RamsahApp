//
//  DataArray.h
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
#define TABLE_NAME @"FavouriteList"

#define FIELD_SUB_ID @"sub_id"
#define FIELD_WORD_ID @"word_id"
#define FIELD_IS @"is_favourite"
#define FIELD_SAVED @"is_saved"

@interface DataArray : NSObject<UIAlertViewDelegate>

@property (nonatomic) sqlite3 *dbHandler;
@property (nonatomic, retain) NSMutableArray* arrMainMenus;
@property (nonatomic, retain) NSMutableArray* arrSubMenus;
@property (nonatomic, retain) NSMutableArray* arrWordLists;
@property (nonatomic, retain) NSMutableArray* arrRamsahs;
@property (nonatomic, retain) NSMutableArray* arrSigns;
@property (nonatomic, retain) NSString* strWebSiteLink;

+(BOOL)createTable:(sqlite3 *)dbHandler;
-(id)initWithDBHandler:(sqlite3*)dbHandler;
-(void)insertFavouriteInformation;
-(BOOL)setFavouriteItem:(int)intSubId wordId:(int)intWordId value:(NSString*)value;
-(BOOL)isFavourite:(int)intSubId wordId:(int)intWordId;
-(void)insertNewWord:(int)intSubId wordId:(int)intWordId;
-(BOOL)is_registered:(int)intSubId wordId:(int)intWordId;
-(void)alert:(NSString*)titleString content:(NSString*)contentString;
-(void)multiAlert:(NSString*)titleString content:(NSString*)contentString;
-(BOOL)isSaved:(int)intSubId wordId:(int)intWordId;
-(BOOL)setSavedItem:(int)intSubId wordId:(int)intWordId value:(NSString*)value;

@end
