//
//  SearchViewController.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "SearchViewController.h"
#import "SOFService.h"
#import <SVProgressHUD.h>
#import <NSString+HTML.h>
#import "DetailObject.h"
#import "DetailViewController.h"
#import "WebViewQuestionViewController.h"

@interface SearchViewController ()
{
    int page;
    BOOL lastpage;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    
    [self.tableView setHidden:YES];
    [super viewDidLoad];
    
    [self.search becomeFirstResponder];
    
    
    page = 1;
    lastpage = false;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.result = [NSArray array];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(lastpage) {
        return self.result.count;
    }
    return self.result.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == self.result.count){
        return 44.0f;
    }
    return 120.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == self.result.count && !lastpage){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    
    NSDictionary *obj = [self.result objectAtIndex:indexPath.row];
    UILabel *detail = (UILabel*)[cell viewWithTag:100];
    detail.text = [[obj objectForKey:@"title"] stringByConvertingHTMLToPlainText];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.result.count > 0){
        if(!lastpage && indexPath.row == self.result.count) {
            page++;
            [SOFService getSearchResultFrom:self.search.text Page:[NSString stringWithFormat:@"%d",page] completeHandler:^(NSArray *result,BOOL isLast) {
                
                lastpage = isLast;
                
                self.result = [self.result arrayByAddingObjectsFromArray:[result copy]];
                NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:self.result ];
                self.result  = [orderedSet array];
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
            } error:^(NSString *error) {
                [SVProgressHUD dismiss];
                [[[UIAlertView alloc] initWithTitle:@"Error Connection" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }];
        }
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    
    [SVProgressHUD showWithStatus:@"Loading"];
    [SOFService getSearchResultFrom:self.search.text Page:[NSString stringWithFormat:@"%d",page] completeHandler:^(NSArray *result,BOOL isLast) {
        
        lastpage = isLast;
        self.result = [result copy];
        
        [self.tableView reloadData];
        [self.tableView setHidden:NO];
        [SVProgressHUD dismiss];
        if(self.result.count == 0){
            [[[UIAlertView alloc] initWithTitle:@"No result" message:@"Please enter a keyword again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    } error:^(NSString *error) {
        [SVProgressHUD dismiss];
        [[[UIAlertView alloc] initWithTitle:@"Error Connection" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *obj = [self.result objectAtIndex:indexPath.row];
    NSLog(@"question link = %@",[obj objectForKey:@"link"]);
    
    [SVProgressHUD showWithStatus:@"Loading"];
    [SOFService getQuestionContentWithQuestionID:[NSString stringWithFormat:@"%@",[obj objectForKey:@"question_id"]]
                                 completeHandler:^(NSString *content) {
                                     NSString *contentString = [content stringByDecodingHTMLEntities];
//                                     contentString = [contentString stringByReplacingOccurrencesOfString:@"<code" withString:@"<acode><code"];
//                                     contentString = [contentString stringByReplacingOccurrencesOfString:@"</code>" withString:@"</code></acode>"];
                                     
                                     WebViewQuestionViewController *web = (WebViewQuestionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"WebviewVC"];
                                     web.content = contentString;
                                     [self.navigationController pushViewController:web animated:YES];
                                     //                                     NSArray *result = [SOFService parseHtmlString:contentString WithTag:@"p"];
                                     //                                     DetailViewController *detail = (DetailViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
                                     //                                     detail.result = [result copy];
                                     //                                     [self.navigationController pushViewController:detail animated:YES];
                                     [SVProgressHUD dismiss];
                                     
                                 }
                                           error:^(NSString *error) {
                                               [[[UIAlertView alloc] initWithTitle:@"Error Connection" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                               [SVProgressHUD dismiss];
                                           }];
}

@end
