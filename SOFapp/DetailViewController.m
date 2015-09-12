//
//  DetailViewController.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailObject.h"

@interface DetailViewController ()
{
    NSMutableArray *heightArray;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    heightArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[heightArray objectAtIndex:indexPath.row] floatValue];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    DetailObject *obj = (DetailObject*)[self.result objectAtIndex:indexPath.row];
    if([obj.type isEqualToString:@"code"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"codeCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
    }
    return cell;
    
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
