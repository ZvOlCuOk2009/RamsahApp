//
//  SignListView.h
//  SingSign
//
//  Created by Luoyan on 9/5/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignListView : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *signListTable;

@property (nonatomic, retain) IBOutlet UILabel *lblArabicTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblEnglishTitle;
@property (nonatomic, retain) IBOutlet UIButton *imgTopIcon;

@property (nonatomic, retain) NSMutableArray* arrSignContents;

@property (nonatomic) int intSubMenuId;
@property (nonatomic) int intWordId;

-(IBAction)returnBefore:(id)sender;

@end
