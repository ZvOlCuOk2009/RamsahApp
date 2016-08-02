//
//  RamsahView.m
//  SingSign
//
//  Created by Luoyan on 9/8/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "RamsahView.h"
#import "AppDelegate.h"
#import "DataModel.h"
#import "DataArray.h"

@interface RamsahView ()

@end

@implementation RamsahView

@synthesize intRamsahId;
@synthesize intSubId;
@synthesize lblArabicTitle;
@synthesize lblEnglishTitle;
@synthesize imgRamsahLogo;
@synthesize imgTopIcon;
@synthesize lblPrefixString;
@synthesize lblRamsahLinkString;
@synthesize txvArabicTopic;
@synthesize txvEnglishTopic;
@synthesize webView;


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
    
    [self setPageInfo];
    [self setFontFamily];
}

- (void)setPageInfo{
    SubMenuRecord *subMenuRecord = [[SubMenuRecord alloc]init];
    subMenuRecord = [gDataArray.arrSubMenus objectAtIndex:intSubId - 1];
    
    lblArabicTitle.text = subMenuRecord.strSubArabic;
    lblEnglishTitle.text = subMenuRecord.strSubEnglish;
    
    NSString *strImageName = @"_";
    strImageName = [strImageName stringByAppendingString:subMenuRecord.strSubIcon];
    
    [imgTopIcon setImage:[UIImage imageNamed:strImageName] forState:0];
    
    RamSahRecord* ramsahRecord = [[RamSahRecord alloc]init];
    
    for (int i = 0 ; i < [gDataArray.arrRamsahs count] ; i ++){
        ramsahRecord = [gDataArray.arrRamsahs objectAtIndex:i];
        if (ramsahRecord.intSubId == intSubId){
            break;
        }
    }
   
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:ramsahRecord.strLinkUrl];
    [attString addAttribute:(NSString*)NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:(NSRange){0,[attString length]}];
    lblRamsahLinkString.attributedText = attString;
    
    
    txvArabicTopic.text = [NSString stringWithFormat:@"%@\n\n%@", ramsahRecord.strRamsahArabic, ramsahRecord.strRamsahEnglish];
//    txvEnglishTopic.text = ramsahRecord.strRamsahEnglish;
    
    [imgRamsahLogo setImage:[UIImage imageNamed:ramsahRecord.strLogoUrl]];
    
    lblRamsahLinkString.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabAction)];
    
    [lblRamsahLinkString addGestureRecognizer:recognizer];
}

- (void)tabAction{
    gDataArray.strWebSiteLink = lblRamsahLinkString.text;
    [self multiAlert:@"Alert" content:@"Do you want to visit our website?\nتبا تطمش على موقعنا، حياك .. إقرب."];
}

- (void)setFontFamily{
    [lblPrefixString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblPrefixString.font.pointSize]];
    lblArabicTitle.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblArabicTitle.font.pointSize];
    lblEnglishTitle.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblEnglishTitle.font.pointSize];
    lblPrefixString.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblPrefixString.font.pointSize];
    lblRamsahLinkString.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblRamsahLinkString.font.pointSize];
    txvArabicTopic.font = [UIFont fontWithName:@"GEFlow-Bold" size:txvArabicTopic.font.pointSize];
    txvEnglishTopic.font = [UIFont fontWithName:@"GEFlow-Bold" size:txvEnglishTopic.font.pointSize];
}

-(void)multiAlert:(NSString*)titleString content:(NSString*)contentString{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleString message:contentString delegate:self cancelButtonTitle:@"No/مب غايته" otherButtonTitles:@"Yes/هيه", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [webView setHidden:NO];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        [webView loadRequest:request];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:lblRamsahLinkString.text]];
    }
}

-(IBAction)returnBefore:(id)sender{    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
