//
//  MainViewController.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/12/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#define imageAnswered [UIImage imageNamed:@"rightIcon2"]
#define imageNotAnswer [UIImage imageNamed:@"rightIcon"]

#import "MainViewController.h"
#import "SOFService.h"
#import <SVProgressHUD.h>

@interface MainViewController ()
{
    int page;
    BOOL lastpage;
    BOOL viewInit;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [self.tableView setHidden:YES];
    [super viewDidLoad];
    page = 1;
    lastpage = false;
    viewInit = false;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.result = [NSArray array];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    if(!viewInit){
        viewInit = true;
        
        [SVProgressHUD showWithStatus:@"Loading"];
        [SOFService listAllQuestionWithFilter:@"" Page:[NSString stringWithFormat:@"%d",page] completeHandler:^(NSArray *result,BOOL isLast) {
            
            lastpage = isLast;
            self.result = [result copy];
            
            [self.tableView reloadData];
            [self.tableView setHidden:NO];
            [SVProgressHUD dismiss];
        } error:^(NSString *error) {
            [SVProgressHUD dismiss];
            [[[UIAlertView alloc] initWithTitle:@"Error Connection" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }];
    }
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
    detail.text = [obj objectForKey:@"title"];
    
    UILabel *answers = (UILabel*)[cell viewWithTag:101];
    answers.text = [NSString stringWithFormat:@"%@ answers",[obj objectForKey:@"answer_count"]];
    
    UIImageView *image = (UIImageView*)[cell viewWithTag:102];
    if([[NSString stringWithFormat:@"%@",[obj objectForKey:@"is_answered"]] isEqualToString:@"1"]){
        [image setImage:imageAnswered];
    }else{
        [image setImage:imageNotAnswer];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!lastpage && indexPath.row == self.result.count) {
        page++;
        [SOFService listAllQuestionWithFilter:@"" Page:[NSString stringWithFormat:@"%d",page] completeHandler:^(NSArray *result,BOOL isLast) {
            
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *obj = [self.result objectAtIndex:indexPath.row];
    
    [SOFService getQuestionContentWithQuestionID:[NSString stringWithFormat:@"%@",[obj objectForKey:@"question_id"]]
                                 completeHandler:^(NSString *content) {
                                     NSLog(@"%@",[content stringByConvertingHTMLToPlainText]);
                                 }
                                error:^(NSString *error) {
                                    NSLog(@"%@",error);
                                }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
