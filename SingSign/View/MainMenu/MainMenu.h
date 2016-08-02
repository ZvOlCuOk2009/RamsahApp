//
//  MainMenu.h
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenu : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UITableView *mainMenuTable;
@property (nonatomic, retain) IBOutlet UISearchBar *txtSeachBar;

@property (nonatomic, retain) NSString* strSearchSign;
@property (nonatomic, retain) NSMutableArray* arrSearchedSigns;

- (IBAction)sendMailFormLoad:(id)sender;
- (IBAction)favouriteListLoad:(id)sender;

@end
