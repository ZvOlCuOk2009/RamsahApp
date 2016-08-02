//
//  DataModel.h
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMenuRecord : NSObject

@property (nonatomic) int intMainId;
@property (nonatomic, retain) NSString* strMenuEnglish;
@property (nonatomic, retain) NSString* strMenuArabic;
@property (nonatomic, retain) NSString* strMenuIcon;

@end

@interface SubMenuRecord : NSObject

@property (nonatomic) int intMainId;
@property (nonatomic) int intSubId;
@property (nonatomic, retain) NSString* strSubEnglish;
@property (nonatomic, retain) NSString* strSubArabic;
@property (nonatomic, retain) NSString* strSubIcon;

@end

@interface WordRecord : NSObject

@property (nonatomic) int intSubId;
@property (nonatomic) int intWordId;
@property (nonatomic, retain) NSString* strSignImageName;
@property (nonatomic, retain) NSString* strEnglish;
@property (nonatomic, retain) NSString* strArabic;
@property (nonatomic, retain) NSString* strRamsah;

@end

@interface RamSahRecord : NSObject

@property (nonatomic) int intSubId;
@property (nonatomic) int intRamsahId;
@property (nonatomic, retain) NSString* strRamsahArabic;
@property (nonatomic, retain) NSString* strRamsahEnglish;
@property (nonatomic, retain) NSString* strLinkUrl;
@property (nonatomic, retain) NSString* strLogoUrl;

@end

@interface SignPositionRecord : NSObject

@property (nonatomic) int intLengthOfSignPosition;
@property (nonatomic, retain) NSString* strSignFileName;

@end

