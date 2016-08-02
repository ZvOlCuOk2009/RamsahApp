//
//  CsvParser.h
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "AppDelegate.h"
#import "DBHandler.h"
#import "DataArray.h"

@implementation DBHandler

@synthesize dbHandler;

+ (id) connectDB {
	DBHandler *newInterface = [[DBHandler alloc] init];
	NSString* db_path = [documentPath stringByAppendingPathComponent:DB_NAME];
	int result = sqlite3_open([db_path UTF8String], &(newInterface->dbHandler));
	
	if (result != SQLITE_OK || ![DataArray createTable:newInterface->dbHandler]) {
		return nil;
	}
	return newInterface;
}

- (void) disconnectDB {
	sqlite3_close(dbHandler);
}

- (void)dealloc {
	[self disconnectDB];
}

@end
