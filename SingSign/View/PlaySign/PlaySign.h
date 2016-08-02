//
//  PlaySign.h
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;

@interface PlaySign : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *lblSignth;
@property (nonatomic, retain) IBOutlet UILabel *lblSignPositionth;
@property (nonatomic, retain) IBOutlet UILabel *lblWord1;
@property (nonatomic, retain) IBOutlet UILabel *lblWord2;
@property (nonatomic, retain) IBOutlet UILabel *lblWord3;
@property (nonatomic, retain) IBOutlet UIImageView *imgSign;
@property (nonatomic, retain) IBOutlet UIButton *imgFavourite;
@property (nonatomic, retain) IBOutlet UIButton *imgPlay;
@property (nonatomic, retain) IBOutlet UIButton *imgBefore;
@property (nonatomic, retain) IBOutlet UIButton *imgNext;
@property (nonatomic, retain) IBOutlet UIButton *imgLoop;
@property (nonatomic, retain) IBOutlet UIButton *imgSave;
@property (nonatomic, retain) IBOutlet UIButton *imgLogo;


@property (nonatomic) int intSubId;
@property (nonatomic) int intWordId;
@property (nonatomic) int intIsFavourite;
@property (nonatomic) int intSaved;
@property (nonatomic) int intTotalList;
@property (nonatomic) int intCurrentPosition;
@property (nonatomic) int intLengthOfPosition;
@property (nonatomic) int intLoop;

@property (nonatomic, retain) NSString* strCurrentSignImageName;

@property (nonatomic, retain) NSTimer *nsTimer;
@property (nonatomic, retain) NSMutableArray* arrGroupSignInfo;

-(IBAction)beforePositionSignLoad:(id)sender;
-(IBAction)nextPositionSignLoad:(id)sender;
-(IBAction)downloadSignImage:(id)sender;
-(IBAction)saveToFavouriteList:(id)sender;
-(IBAction)beforeSignLoad:(id)sender;
-(IBAction)nextSignLoad:(id)sender;
-(IBAction)repeatCurrentSign:(id)sender;
-(IBAction)playCurrentSign:(id)sender;
-(IBAction)returnBefore:(id)sender;

@end
