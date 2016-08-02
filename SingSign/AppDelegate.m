//
//  AppDelegate.m
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "AppDelegate.h"
#import "Splash.h"
#import "MainMenu.h"
#import "DataModel.h"
#import "CsvParser.h"
#import "DataArray.h"
#import "DBHandler.h"

@implementation AppDelegate

@synthesize splashView;
@synthesize mainMenuView;

DataArray *gDataArray;
DBHandler *gDbHandler;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self displayFontFamilyName];
    
    gDbHandler = [[DBHandler alloc]init];
    gDbHandler = [DBHandler connectDB];
    sqlite3* dbHandler = [gDbHandler getDbHandler];
    
    gDataArray = [[DataArray alloc] initWithDBHandler:dbHandler];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    splashView = [[Splash alloc] initWithNibName:@"Splash" bundle:nil];
    [self.window addSubview:splashView.view];
    
    [self loadData];

    [gDataArray insertFavouriteInformation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = splashView;
    NSLog(@"%@", NSHomeDirectory());
    
    return YES;
}

- (void)displayFontFamilyName{
    for (NSString* family in [UIFont familyNames]){
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            NSLog(@"  %@", name);
        }
    }
}

- (void)loadData{
    CsvParser *csvParser = [[CsvParser alloc]init];
    
    [csvParser returnCsvContentString:@"main_menu"];
    
    gDataArray.arrMainMenus = [[NSMutableArray alloc]init];
    
    MainMenuRecord *mainMenuRecord;
    NSArray *arrRecord = [[NSArray alloc]init];
    
    for (int i = 0 ; i < [csvParser.arrContent count] ; i ++){
        arrRecord = [[csvParser.arrContent objectAtIndex:i] componentsSeparatedByString:@","];
        if ([arrRecord count] == 1)break;
        
        mainMenuRecord = [[MainMenuRecord alloc]init];
        
        mainMenuRecord.intMainId = [arrRecord[0] intValue];
        mainMenuRecord.strMenuEnglish = arrRecord[1];
        mainMenuRecord.strMenuArabic = arrRecord[2];
        mainMenuRecord.strMenuIcon = arrRecord[3];
        
        [gDataArray.arrMainMenus addObject:mainMenuRecord];
    }
    
    [csvParser returnCsvContentString:@"sub_menu"];
    
    gDataArray.arrSubMenus = [[NSMutableArray alloc]init];
    
    SubMenuRecord *subMenuRecord;
    arrRecord = [[NSArray alloc]init];
    
    for (int i = 0 ; i < [csvParser.arrContent count] ; i ++){
        arrRecord = [[csvParser.arrContent objectAtIndex:i] componentsSeparatedByString:@","];
        if ([arrRecord count] == 1)break;
        
        subMenuRecord = [[SubMenuRecord alloc]init];
        
        subMenuRecord.intMainId = [arrRecord[0] intValue];
        subMenuRecord.intSubId = [arrRecord[1] intValue];
        subMenuRecord.strSubEnglish = arrRecord[2];
        subMenuRecord.strSubArabic = arrRecord[3];
        subMenuRecord.strSubIcon = arrRecord[4];
        
        [gDataArray.arrSubMenus addObject:subMenuRecord];
    }
    
    [csvParser returnCsvContentString:@"sign_list"];
    
    gDataArray.arrWordLists = [[NSMutableArray alloc]init];
    
    WordRecord *wordRecord;
    arrRecord = [[NSArray alloc]init];
    
    for (int i = 0 ; i < [csvParser.arrContent count] ; i ++){
        arrRecord = [[csvParser.arrContent objectAtIndex:i] componentsSeparatedByString:@","];
        if ([arrRecord count] == 1)break;
        
        wordRecord = [[WordRecord alloc]init];
        
        wordRecord.intSubId = [arrRecord[0] intValue];
        wordRecord.strSignImageName = arrRecord[5];
        wordRecord.strEnglish = arrRecord[2];
        wordRecord.strArabic = arrRecord[1];
        wordRecord.strRamsah = arrRecord[3];
        wordRecord.intWordId = [arrRecord[4] intValue];
        
        [gDataArray.arrWordLists addObject:wordRecord];
    }
    
    [csvParser returnCsvContentString:@"ramsah"];
    gDataArray.arrRamsahs = [[NSMutableArray alloc]init];
    
    RamSahRecord *ramsahRecord;
    arrRecord = [[NSArray alloc]init];
    
    for (int i = 0 ; i < [csvParser.arrContent count] ; i ++){
        arrRecord = [[csvParser.arrContent objectAtIndex:i] componentsSeparatedByString:@","];
        if ([arrRecord count] == 1)break;
        
        ramsahRecord = [[RamSahRecord alloc]init];
        
        ramsahRecord.intSubId = [arrRecord[0] intValue];
        ramsahRecord.intRamsahId = [arrRecord[1] intValue];
        ramsahRecord.strRamsahEnglish = arrRecord[2];
        ramsahRecord.strRamsahArabic = arrRecord[3];
        ramsahRecord.strLinkUrl = arrRecord[4];
        ramsahRecord.strLogoUrl = arrRecord[5];
        
        [gDataArray.arrRamsahs addObject:ramsahRecord];
    }
    
    [csvParser returnCsvContentString:@"sign_info"];
    gDataArray.arrSigns = [[NSMutableArray alloc]init];
    
    SignPositionRecord *signPositionRecord;
    arrRecord = [[NSArray alloc]init];
    
    for (int i = 0 ; i < [csvParser.arrContent count] ; i ++){
        arrRecord = [[csvParser.arrContent objectAtIndex:i] componentsSeparatedByString:@","];
        if ([arrRecord count] == 1)break;

        signPositionRecord = [[SignPositionRecord alloc]init];
        
        signPositionRecord.intLengthOfSignPosition = [arrRecord[1] intValue];
        signPositionRecord.strSignFileName = arrRecord[0];
        
        [gDataArray.arrSigns addObject:signPositionRecord];
    }
}

//after loading splash, move to main menu.
- (void) loadMainMenu{
    mainMenuView = [[MainMenu alloc] initWithNibName:@"MainMenu" bundle:nil];
    UINavigationController* rootNavigationController = [[UINavigationController alloc] initWithRootViewController:mainMenuView];
    [rootNavigationController setNavigationBarHidden:YES];
    
    [self.window setRootViewController:rootNavigationController];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
