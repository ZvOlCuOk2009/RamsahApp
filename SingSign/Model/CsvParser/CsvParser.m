//
//  CsvParser.m
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "CsvParser.h"

@implementation CsvParser

@synthesize arrContent;

- (void)returnCsvContentString:(NSString *)fileName{
    NSString* strBundle = [[NSBundle mainBundle] pathForResource:fileName ofType:@"csv"];
    NSString *fileObj = [NSString stringWithContentsOfFile:strBundle encoding:NSUTF8StringEncoding error:nil];
    self.arrContent = [fileObj componentsSeparatedByString:@"\r\n"];
}

@end
