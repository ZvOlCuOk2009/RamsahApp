//
//  CsvParser.h
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CsvParser : NSObject{
    NSArray *arrContent;
}

@property (nonatomic, retain) NSArray *arrContent;

- (void) returnCsvContentString: (NSString*)fileName;

@end
