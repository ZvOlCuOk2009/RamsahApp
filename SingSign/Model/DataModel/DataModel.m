//
//  DataModel.m
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "DataModel.h"

@implementation MainMenuRecord

@synthesize intMainId;
@synthesize strMenuArabic;
@synthesize strMenuEnglish;
@synthesize strMenuIcon;

@end

@implementation SubMenuRecord

@synthesize intMainId;
@synthesize intSubId;
@synthesize strSubArabic;
@synthesize strSubEnglish;
@synthesize strSubIcon;

@end

@implementation WordRecord

@synthesize intSubId;
@synthesize intWordId;
@synthesize strSignImageName;
@synthesize strArabic;
@synthesize strEnglish;
@synthesize strRamsah;

@end

@implementation RamSahRecord

@synthesize strLinkUrl;
@synthesize strLogoUrl;
@synthesize strRamsahArabic;
@synthesize strRamsahEnglish;
@synthesize intSubId;
@synthesize intRamsahId;

@end

@implementation SignPositionRecord

@synthesize intLengthOfSignPosition;
@synthesize strSignFileName;

@end

