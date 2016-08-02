//
//  SignKindMenu.h
//  SingSign
//
//  Created by Luoyan on 9/7/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignKindMenu : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, retain) IBOutlet UITableView *signKindTable;
@property (nonatomic, retain) IBOutlet UILabel *lblSignKindArabicTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblSignKindEnglishTitle;

@property (nonatomic, retain) NSMutableArray* arrSignKindPageContents;

@property (nonatomic)int intMainMenuId;
@property (nonatomic)int intSubMenuId;

- (IBAction)returnBefore:(id)sender;

@end
