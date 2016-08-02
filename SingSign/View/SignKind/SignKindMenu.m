//
//  SignKindMenu.m
//  SingSign
//
//  Created by Luoyan on 9/7/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "SignKindMenu.h"
#import "ListCell.h"
#import "SignListView.h"
#import "AppDelegate.h"
#import "DataArray.h"
#import "DataModel.h"
#import "RamsahView.h"

@interface SignKindMenu ()

@end

@implementation SignKindMenu

@synthesize lblSignKindArabicTitle;
@synthesize lblSignKindEnglishTitle;
@synthesize intMainMenuId;
@synthesize intSubMenuId;
@synthesize arrSignKindPageContents;

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

- (void)setFontFamily{
    [lblSignKindArabicTitle setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblSignKindArabicTitle.font.pointSize]];
    lblSignKindEnglishTitle.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblSignKindEnglishTitle.font.pointSize];
}

- (void)setPageInfo{
    arrSignKindPageContents = [[NSMutableArray alloc]init];
    SubMenuRecord *submenuRecord;
    
    for (int i = 0 ; i < [gDataArray.arrSubMenus count] ; i ++){
        submenuRecord = [[SubMenuRecord alloc]init];
        submenuRecord = [gDataArray.arrSubMenus objectAtIndex:i];
        
        if (intMainMenuId == submenuRecord.intMainId){
            [arrSignKindPageContents addObject:submenuRecord];
        }
    }
    
    MainMenuRecord *mainMenuRecord = [[MainMenuRecord alloc]init];
    mainMenuRecord = [gDataArray.arrMainMenus objectAtIndex:intMainMenuId - 1];
    
    lblSignKindArabicTitle.text = mainMenuRecord.strMenuArabic;
    lblSignKindEnglishTitle.text = mainMenuRecord.strMenuEnglish;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrSignKindPageContents count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubMenuRecord* subMenuRecord = [[SubMenuRecord alloc]init];
    subMenuRecord = [arrSignKindPageContents objectAtIndex:indexPath.row];
    
    if ([lblSignKindEnglishTitle.text isEqualToString:@"About Ramsah"]){
        RamsahView *ramsahView = [[RamsahView alloc] initWithNibName:@"RamsahView" bundle:nil];
        
        ramsahView.intSubId = subMenuRecord.intSubId;
        
        [self.navigationController pushViewController:ramsahView animated:YES];
    } else {
        SignListView *signListView = [[SignListView alloc] initWithNibName:@"SignListView" bundle:nil];
         
        signListView.intSubMenuId = subMenuRecord.intSubId;
        
        [self.navigationController pushViewController:signListView animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *listCell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    listCell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] objectAtIndex:0];
    
    SubMenuRecord* subMenuRecord = [[SubMenuRecord alloc]init];
    
    subMenuRecord = [arrSignKindPageContents objectAtIndex:indexPath.row];
    
    listCell.lblArabicMenuString.text = subMenuRecord.strSubArabic;
    listCell.lblEnglishMenuString.text = subMenuRecord.strSubEnglish;
    [listCell.imgMenuIcon setImage:[UIImage imageNamed:subMenuRecord.strSubIcon] forState:0];
    
    [listCell.lblEnglishMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblEnglishMenuString.font.pointSize]];
    [listCell.lblArabicMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblArabicMenuString.font.pointSize]];
    
    return listCell;
}


- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 96;
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
