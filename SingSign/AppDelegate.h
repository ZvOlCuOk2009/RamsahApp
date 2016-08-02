//
//  AppDelegate.h
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Splash;
@class MainMenu;
@class DataArray;
@class DBHandler;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) Splash *splashView;
@property (nonatomic, retain) MainMenu *mainMenuView;

- (void) loadMainMenu;

@end

extern DataArray *gDataArray;
extern DBHandler *gDbHandler;
