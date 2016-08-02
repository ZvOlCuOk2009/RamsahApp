//
//  RamsahView.h
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RamsahView : UIViewController<UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *lblArabicTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblEnglishTitle;
@property (nonatomic, retain) IBOutlet UIButton *imgTopIcon;
@property (nonatomic, retain) IBOutlet UIImageView *imgRamsahLogo;
@property (nonatomic, retain) IBOutlet UILabel *lblRamsahLinkString;
@property (nonatomic, retain) IBOutlet UITextView *txvArabicTopic;
@property (nonatomic, retain) IBOutlet UITextView *txvEnglishTopic;
@property (nonatomic, retain) IBOutlet UILabel *lblPrefixString;
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic) int intSubId;
@property (nonatomic) int intRamsahId;

-(IBAction)returnBefore:(id)sender;

@end
