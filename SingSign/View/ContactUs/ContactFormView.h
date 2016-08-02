//
//  ContactFormView.h
//  SingSign
//
//  Created by Luoyan on 9/5/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactFormView : UIViewController<MFMailComposeViewControllerDelegate, UITextFieldDelegate>
@property (nonatomic, retain) NSString* strTargetEmailAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@property (nonatomic, retain) IBOutlet UITextField *txfUserName;
@property (nonatomic, retain) IBOutlet UITextField *txfUserPhoneNumber;
@property (nonatomic, retain) IBOutlet UITextField *txfEmailSubject;
@property (nonatomic, retain) IBOutlet UITextView *txvEmailContent;

@property (nonatomic, retain) IBOutlet UILabel *lblName1;
@property (nonatomic, retain) IBOutlet UILabel *lblPhone1;
@property (nonatomic, retain) IBOutlet UILabel *lblSubject1;
@property (nonatomic, retain) IBOutlet UILabel *lblMessage1;
@property (nonatomic, retain) IBOutlet UILabel *lblName2;
@property (nonatomic, retain) IBOutlet UILabel *lblPhone2;
@property (nonatomic, retain) IBOutlet UILabel *lblSubject2;
@property (nonatomic, retain) IBOutlet UILabel *lblMessage2;
@property (nonatomic, retain) IBOutlet UIButton *btnSendEmail;

@property (nonatomic, retain) IBOutlet UILabel *lblTitleArabic;
@property (nonatomic, retain) IBOutlet UILabel *lblTitleEnglish;

- (IBAction)returnBefore:(id)sender;
- (IBAction)sendMail:(id)sender;


@end
