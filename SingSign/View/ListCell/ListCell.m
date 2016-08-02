//
//  ListCell.m
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

@synthesize imgMenuIcon;
@synthesize lblArabicMenuString;
@synthesize lblEnglishMenuString;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
