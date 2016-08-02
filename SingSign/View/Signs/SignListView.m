//
//  SignListView.m
//  SingSign
//
//  Created by Luoyan on 9/5/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#import "SignListView.h"
#import "SignCell.h"
#import "PlaySign.h"
#import "AppDelegate.h"
#import "DataModel.h"
#import "DataArray.h"

@interface SignListView ()

@end

@implementation SignListView

@synthesize signListTable;
@synthesize lblArabicTitle;
@synthesize lblEnglishTitle;
@synthesize arrSignContents;
@synthesize intWordId;
@synthesize intSubMenuId;
@synthesize imgTopIcon;

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

    [self setFontFamily];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setPageInfo];
}

- (void)setFontFamily{
    [lblArabicTitle setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblArabicTitle.font.pointSize]];
    lblEnglishTitle.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblEnglishTitle.font.pointSize];
}

- (void)setPageInfo{
    arrSignContents = [[NSMutableArray alloc]init];
    WordRecord *wordRecord;
    
    if (intSubMenuId == -1){
        for (int i = 0 ; i < [gDataArray.arrWordLists count] ; i ++){
            wordRecord = [[WordRecord alloc]init];
            wordRecord = [gDataArray.arrWordLists objectAtIndex:i];
            
            if ([gDataArray isFavourite:wordRecord.intSubId wordId:wordRecord.intWordId]){
                [arrSignContents addObject:wordRecord];
            }
        }
        
        lblArabicTitle.text = @"المفضلة";
        lblEnglishTitle.text = @"Favourites";
        
        [imgTopIcon setImage:[UIImage imageNamed:@"FavouriteTitleIcon.png"] forState:0];
    } else {
        for (int i = 0 ; i < [gDataArray.arrWordLists count] ; i ++){
            wordRecord = [[WordRecord alloc]init];
            wordRecord = [gDataArray.arrWordLists objectAtIndex:i];
            
            if (intSubMenuId == wordRecord.intSubId){
                [arrSignContents addObject:wordRecord];
            }
        }
        
        SubMenuRecord *subMenuRecord = [[SubMenuRecord alloc]init];
        subMenuRecord = [gDataArray.arrSubMenus objectAtIndex:intSubMenuId - 1];
        
        lblArabicTitle.text = subMenuRecord.strSubArabic;
        lblEnglishTitle.text = subMenuRecord.strSubEnglish;
        
        NSString *strImageName = @"_";
        strImageName = [strImageName stringByAppendingString:subMenuRecord.strSubIcon];
        
        [imgTopIcon setImage:[UIImage imageNamed:strImageName] forState:0];
    }
    
    [signListTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrSignContents count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaySign *playSign = [[PlaySign alloc]initWithNibName:@"PlaySign" bundle:nil];
    
    WordRecord* wordRecord = [[WordRecord alloc]init];
    
    wordRecord = [arrSignContents objectAtIndex:indexPath.row];
    
    playSign.intSubId = wordRecord.intSubId;
    playSign.intWordId = indexPath.row + 1;
    playSign.intTotalList = [arrSignContents count];
    playSign.arrGroupSignInfo = arrSignContents;
    
    [self.navigationController pushViewController:playSign animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SignCell *signCell = (SignCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    signCell = [[[NSBundle mainBundle] loadNibNamed:@"SignCell" owner:self options:nil] objectAtIndex:0];
    
    WordRecord *wordRecord = [[WordRecord alloc]init];
    wordRecord = [arrSignContents objectAtIndex:indexPath.row];
    
    signCell.lblWord.text = [NSString stringWithFormat:@"%@(%@)", wordRecord.strEnglish, wordRecord.strArabic];
    
    [signCell.lblWord setFont:[UIFont fontWithName:@"GEFlow-Bold" size:signCell.lblWord.font.pointSize]];
    
    return signCell;
}


- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 43;
}

-(IBAction)returnBefore:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
