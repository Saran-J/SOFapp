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
    for (int i = 0;i<self.result.count;i++){
        [heightArray addObject:@"44"];
    }
    
    [self.tableView reloadData];
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
    UILabel *content = (UILabel *)[cell viewWithTag:100];
    content.lineBreakMode = NSLineBreakByWordWrapping;
    content.numberOfLines = 0;
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:obj.content];
    
    NSArray *words=[obj.content componentsSeparatedByString:@"(h)"];
    
    for (NSString *word in words) {
        if ([word hasPrefix:@"@"]) {
            NSRange range=[obj.content rangeOfString:word];
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            
        }
    }
    
    
    NSRange range = [[string string] rangeOfString:@"(h)@"];
    if(range.location != NSNotFound){
        [string replaceCharactersInRange:range withString:@""];
    }
    NSRange range2 = [[string string] rangeOfString:@"(h)"];
    if(range2.location != NSNotFound){
        [string replaceCharactersInRange:range2 withString:@""];
    }

    [content sizeToFit];
    [content setAttributedText:string];
    
    
    content.layer.cornerRadius = 15.0f;
    
//    if([[heightArray objectAtIndex:indexPath.row] isEqualToString:@"44"]){
        CGFloat contentHeight = content.frame.size.height;
        CGFloat dif = [obj.type isEqualToString:@"code"] ? 35.0f : 16.0f;
    
        heightArray[indexPath.row] = [NSString stringWithFormat:@"%f",contentHeight+dif];
        
//    }
    [self.tableView reloadData];
    
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
