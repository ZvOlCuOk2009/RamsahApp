//
//  ContactFormView.m
//  SingSign
//
//  Created by Luoyan on 9/5/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "ContactFormView.h"

@interface ContactFormView ()

@end

@implementation ContactFormView

@synthesize lblMessage1;
@synthesize lblMessage2;
@synthesize lblName1;
@synthesize lblName2;
@synthesize lblPhone1;
@synthesize lblPhone2;
@synthesize lblSubject1;
@synthesize lblSubject2;
@synthesize btnSendEmail;
@synthesize txfEmailSubject;
@synthesize txfUserName;
@synthesize txfUserPhoneNumber;
@synthesize txvEmailContent;
@synthesize lblTitleArabic;
@synthesize lblTitleEnglish;
@synthesize strTargetEmailAddress;
@synthesize lblMessage;

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
    strTargetEmailAddress = @"belhaj21@gmail.com";
    [self setFontFamily];
}

- (void)setFontFamily{
    [lblMessage1 setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblMessage1.font.pointSize]];
    [lblMessage setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblMessage.font.pointSize]];
    lblMessage2.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblMessage2.font.pointSize];
    lblName1.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblName1.font.pointSize];
    [lblName2 setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblName2.font.pointSize]];
    lblPhone1.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblPhone1.font.pointSize];
    lblPhone2.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblPhone2.font.pointSize];
    [lblSubject1 setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblSubject1.font.pointSize]];
    lblSubject2.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblSubject2.font.pointSize];
    [lblTitleArabic setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblTitleArabic.font.pointSize]];
    lblTitleEnglish.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblTitleEnglish.font.pointSize];
    [btnSendEmail.titleLabel setFont:[UIFont fontWithName:@"GEFlow-Bold" size:btnSendEmail.titleLabel.font.pointSize]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
}

- (IBAction)returnBefore:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)isTypedAllInfo{
    if ([txfUserName.text isEqualToString:@""]){
        [self showMessage:@"ما عليك أماره، أكتب إسمك"];
        [txfUserName becomeFirstResponder];
        return FALSE;
    }
    
    
    if ([txfUserPhoneNumber.text isEqualToString:@""]){
        [self showMessage:@"نبا رقم تلفونك"];
        [txfUserPhoneNumber becomeFirstResponder];
        return FALSE;
    }
    
    if ([txfEmailSubject.text isEqualToString:@""]){
        [self showMessage:@"شو الموضوع الي تبا تخاطبنا فيه"];
        [txfEmailSubject becomeFirstResponder];
        return FALSE;
    }
    
    /*
    if ([txvEmailContent.text isEqualToString:@""]){
        [self showMessage:@"Please type Content."];
        [txvEmailContent becomeFirstResponder];
        return FALSE;
    }
     */
    
    return TRUE;
}

- (IBAction)sendMail:(id)sender{
    if(![self isTypedAllInfo])return;
    
    NSString *emailSubject = txfEmailSubject.text;
    NSString *messageBody = [NSString stringWithFormat:@"<span style='color:blue;'>%@</span><br><small style='color:red;'>From: </small><small style='color:green;'>%@</small><br><small style='color:red;'>Phone Number: </small><small style='color:green;'>%@</small>", txvEmailContent.text, txfUserName.text, txfUserPhoneNumber.text];
    NSArray *toRecipents = [NSArray arrayWithObject:strTargetEmailAddress];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]){
        mc.mailComposeDelegate = self;
        [mc setSubject:emailSubject];
        [mc setMessageBody:messageBody isHTML:YES];
        [mc setToRecipients:toRecipents];
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void)showMessage:(NSString*)strMessage{
    lblMessage.text = strMessage;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self showMessage:@"Mail cancelled"];
            break;
        case MFMailComposeResultSaved:
            [self showMessage:@"Mail saved"];
            break;
        case MFMailComposeResultSent:
            [self showMessage:@"Mail sent"];
            break;
        case MFMailComposeResultFailed:
            [self showMessage:[NSString stringWithFormat:@"Mail sent failure: %@", [error localizedDescription]]];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
