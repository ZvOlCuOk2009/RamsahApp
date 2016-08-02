//
//  PlaySign.m
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "PlaySign.h"
#import "AppDelegate.h"
#import "DataArray.h"
#import "DataModel.h"
#import "math.h"

@interface PlaySign ()

@end

@implementation PlaySign

@synthesize lblSignPositionth;
@synthesize lblSignth;
@synthesize lblWord1;
@synthesize lblWord2;
@synthesize lblWord3;
@synthesize imgSign;
@synthesize intWordId;
@synthesize imgFavourite;
@synthesize intIsFavourite;
@synthesize intTotalList;
@synthesize intSubId;
@synthesize intCurrentPosition;
@synthesize intLengthOfPosition;
@synthesize intLoop;
@synthesize nsTimer;
@synthesize arrGroupSignInfo;
@synthesize strCurrentSignImageName;
@synthesize imgBefore;
@synthesize imgLoop;
@synthesize imgNext;
@synthesize imgPlay;
@synthesize imgSave;
@synthesize intSaved;
@synthesize imgLogo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setFontFamily];
    [self setPageInfo];
}

- (void)setFontFamily{
    [lblWord1 setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblWord1.font.pointSize]];
    lblWord2.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblWord2.font.pointSize];
    lblWord3.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblWord3.font.pointSize];
}

- (void)setFavouriteButtonImage{
    NSString* strImagePath = intIsFavourite == 1 ? @"RemoveFromFavorite.png" : @"RegisterToFavorite.png";
    [imgFavourite setImage:[UIImage imageNamed:strImagePath] forState:0];
    strImagePath = intSaved == 1 ? @"SaveActive.png" : @"Save.png";
    [imgSave setImage:[UIImage imageNamed:strImagePath] forState:0];
}

-(void)setPageInfo{
    [self initializeTimer];
    intLoop = 0;
    intCurrentPosition = 1;
    
    [self loadNewSignPosition];
    
    imgLogo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabAction)];
    
    [imgLogo addGestureRecognizer:recognizer];
}

- (NSString*)strFullImageName:(NSString*)strImageName position:(int)intPosition{
    NSString* strAccordingRelation = @"_abcdefghijklmnopqrstuvwxyz";
    NSString* strTempImageName = @"";
    
    strTempImageName = [NSString stringWithFormat:@"%@-%@.png", strImageName, [strAccordingRelation substringWithRange:NSMakeRange(intPosition, 1)]];
    return strTempImageName;
}


- (void)tabAction{
    [self.view removeFromSuperview];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate loadMainMenu];
}

-(void)loadNewSignPosition{
    WordRecord* wordRecord = [[WordRecord alloc]init];
    
    wordRecord = [arrGroupSignInfo objectAtIndex:intWordId - 1];
    
    intSubId = wordRecord.intSubId;
    
    intIsFavourite = [gDataArray isFavourite:intSubId wordId:wordRecord.intWordId] ? 1 : 0;
    intSaved = [gDataArray isSaved:intSubId wordId:intWordId] ? 1 : 0;
    
    [self setFavouriteButtonImage];
    
    NSString *strFileName = wordRecord.strSignImageName;
    
    for (int i = 0 ; i < [gDataArray.arrSigns count] ; i ++){
        SignPositionRecord *signPositionRecord = [[SignPositionRecord alloc]init];
        signPositionRecord = [gDataArray.arrSigns objectAtIndex:i];
        
        if ([signPositionRecord.strSignFileName isEqualToString:strFileName]){
            strCurrentSignImageName = strFileName;
            intLengthOfPosition = signPositionRecord.intLengthOfSignPosition;
            break;
        }
    }
    
    lblWord1.text = wordRecord.strArabic;
    lblWord2.text = wordRecord.strEnglish;
    lblWord3.text = wordRecord.strRamsah;
    
    lblSignth.text = [NSString stringWithFormat:@"%ld/%d", (long)intWordId, intTotalList];
    [imgSign setImage:[UIImage imageNamed:[self strFullImageName:wordRecord.strSignImageName position:intCurrentPosition]]];
    lblSignPositionth.text = [NSString stringWithFormat:@"%d/%d", intCurrentPosition, intLengthOfPosition];
}

-(IBAction)beforePositionSignLoad:(id)sender{
    [self initializeTimer];
    intCurrentPosition = (intCurrentPosition - 2 + intLengthOfPosition) % intLengthOfPosition + 1;
    [self loadNewSignPosition];
}

-(IBAction)nextPositionSignLoad:(id)sender{
    [self initializeTimer];
    intCurrentPosition = intCurrentPosition  % intLengthOfPosition + 1;
    [self loadNewSignPosition];
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage
          didFinishSavingWithError:(NSError *)paramError
                       contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

-(IBAction)downloadSignImage:(id)sender{
    [self initializeTimer];
    
    NSMutableArray *arrUiImages = [[NSMutableArray alloc]init];

    UIImage* imgTemp;

    for (int i = 0 ; i < intLengthOfPosition ; i ++){
        imgTemp = [UIImage imageNamed:[self strFullImageName:strCurrentSignImageName position:i + 1]];
        [arrUiImages addObject: imgTemp];
    }
    
    UIImage* imgComposedImage = [self mergeImagesFromArray:arrUiImages];
    
    SEL selectorToCall =
    @selector(imageWasSavedSuccessfully:didFinishSavingWithError:\
              contextInfo:);
    
    UIImageWriteToSavedPhotosAlbum(imgComposedImage, self, selectorToCall, NULL);
    
    WordRecord* wordRecord = [[WordRecord alloc]init];
    wordRecord = [arrGroupSignInfo objectAtIndex:intWordId - 1];
    
    if ([gDataArray setSavedItem:intSubId wordId:wordRecord.intWordId value:@"true"]){
        intSaved = 1;
        [self setFavouriteButtonImage];
    }
}

- (UIImage *)mergeImagesFromArray: (NSMutableArray *)imageArray {
    if ([imageArray count] == 0) return nil;
    
    int intTotalImages = (int)[imageArray count];
    int intRows = sqrt((double)intTotalImages);
    int intMultifliedValue = intRows * intRows;
    if (intTotalImages != intMultifliedValue)intRows++;
    int intColumns = ceil((double)intTotalImages / (double)intRows);
    
    
    UIImage *exampleImage = [imageArray firstObject];
    CGSize imageSize = exampleImage.size;
    CGSize finalSize = CGSizeMake(imageSize.width * (CGFloat)intColumns, imageSize.height * (CGFloat)intRows);
    
    UIGraphicsBeginImageContext(finalSize);
    
    for (UIImage *image in imageArray) {
        int intImageNumber = (int)[imageArray indexOfObject: image];
        int intRow = intImageNumber % intRows;
        int intColumn = intImageNumber / intRows;
        
        [image drawInRect: CGRectMake(imageSize.width * (NSUInteger)intColumn, imageSize.height * (NSUInteger)intRow, imageSize.width, imageSize.height)];
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

-(IBAction)saveToFavouriteList:(id)sender{
    WordRecord* wordRecord = [[WordRecord alloc]init];
    wordRecord = [arrGroupSignInfo objectAtIndex:intWordId - 1];
    
    [self initializeTimer];
    NSString* updateValue = intIsFavourite == 1 ? @"false" : @"true";
    NSString* strAlertContent;

    strAlertContent = intIsFavourite == 0 ? @"Registered in favourite list successfully!" : @"Removed from favourite list successfully!";
    
    if ([gDataArray setFavouriteItem:intSubId wordId:wordRecord.intWordId value:updateValue]){
        intIsFavourite = 1 - intIsFavourite;
        [self setFavouriteButtonImage];
//        [gDataArray alert:@"Message" content:strAlertContent];
    }
}

-(IBAction)beforeSignLoad:(id)sender{
    [self initializeTimer];
    intWordId = (intWordId - 2 + intTotalList) % intTotalList + 1;
    intCurrentPosition = 1;
    [self loadNewSignPosition];
    [imgBefore setImage:[UIImage imageNamed:@"BeforePlayActive.png"] forState:0];
}

-(IBAction)nextSignLoad:(id)sender{
    [self initializeTimer];
    intWordId = intWordId % intTotalList + 1;
    intCurrentPosition = 1;
    [self loadNewSignPosition];
    [imgNext setImage:[UIImage imageNamed:@"NextPlayActive.png"] forState:0];
}

-(void)initializeTimer{
    [imgPlay setImage:[UIImage imageNamed:@"CurrentPlay.png"] forState:0];
    [imgNext setImage:[UIImage imageNamed:@"NextPlay.png"] forState:0];
    [imgLoop setImage:[UIImage imageNamed:@"RepeatPlay.png"] forState:0];
    [imgBefore setImage:[UIImage imageNamed:@"BeforePlay.png"] forState:0];
    
    [nsTimer invalidate];
    nsTimer = [[NSTimer alloc]init];
}

- (void)animateScreen{
    [self loadNewSignPosition];
    
    if (intCurrentPosition == intLengthOfPosition && intLoop == 0){
        [self initializeTimer];
    }
    
    intCurrentPosition = intCurrentPosition  % intLengthOfPosition + 1;
}

-(IBAction)repeatCurrentSign:(id)sender{
    intLoop = 1;
    intCurrentPosition = 1;
    [self initializeTimer];
    nsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animateScreen) userInfo:nil repeats:YES];
    [imgLoop setImage:[UIImage imageNamed:@"RepeatPlayActive.png"] forState:0];
}

-(IBAction)playCurrentSign:(id)sender{
    intLoop = 0;
    intCurrentPosition = 1;
    
    [self initializeTimer];
    
    nsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animateScreen) userInfo:nil repeats:YES];
    [imgPlay setImage:[UIImage imageNamed:@"CurrentPlayActive.png"] forState:0];
}

-(IBAction)returnBefore:(id)sender{
    [self initializeTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
