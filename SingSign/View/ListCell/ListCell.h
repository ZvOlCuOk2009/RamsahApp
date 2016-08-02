//
//  ListCell.h
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *lblArabicMenuString;
@property (nonatomic, retain) IBOutlet UILabel *lblEnglishMenuString;
@property (nonatomic, retain) IBOutlet UIButton *imgMenuIcon;

@end
