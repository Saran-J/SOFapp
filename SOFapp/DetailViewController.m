//
//  DetailViewController.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailObject.h"
#import "ContentCell.h"
#import "CodeCell.h"
#import <NSString+HTML.h>

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
    CGFloat contentHeight = 0;
    
    NSLog(@"content = %@",obj.content);
    if([obj.type isEqualToString:@"code"]){
        CodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"codeCell"];
        UIView *bgView = [cell viewWithTag:101];
        bgView.layer.cornerRadius = 10.0f;
//        cell.content.numberOfLines = 0;
//        cell.content.lineBreakMode = NSLineBreakByWordWrapping;
       
        if(!cell.content){
            cell.content = [[UILabel alloc] init];
        }
        cell.content.numberOfLines = 0;
        cell.content.lineBreakMode = NSLineBreakByWordWrapping;
        cell.content.text = obj.content;
        cell.content.textColor = [UIColor blueColor];
        CGSize sizeThatFitsTextView = [cell.content sizeThatFits:CGSizeMake(self.view.frame.size.width-32, FLT_MAX)];
        
        NSLog(@"size = %f %f",self.view.frame.size.width,sizeThatFitsTextView.height);
        
        CGRect frame = cell.content.frame;
        frame.origin.x = 16;
        frame.origin.y = 15;
        frame.size = sizeThatFitsTextView;
//        frame.size.height -= 30;
        [cell.content setFrame:frame];
        [cell addSubview:cell.content];
        [cell layoutIfNeeded];
        
        contentHeight = cell.content.frame.size.height;
        
        CGFloat dif = 35.0f;
        
        heightArray[indexPath.row] = [NSString stringWithFormat:@"%f",contentHeight+dif];
        

        [self.tableView reloadData];
        
        return cell;
    }else{
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
        
        obj.content = [obj.content stringByConvertingHTMLToPlainText];
        if(!cell.content){
            cell.content = [[UILabel alloc] init];
        }
        cell.content.numberOfLines = 0;
        cell.content.lineBreakMode = NSLineBreakByWordWrapping;
        cell.content.text = obj.content;
        
        CGSize sizeThatFitsTextView = [cell.content sizeThatFits:CGSizeMake(self.view.frame.size.width-20, FLT_MAX)];
        
        NSLog(@"size = %f %f",self.view.frame.size.width,sizeThatFitsTextView.height);
        
        CGRect frame = cell.content.frame;
        frame.origin.x = 10;
        
        frame.origin.y = 5;
        frame.size = sizeThatFitsTextView;
//        frame.size.height -= 10;
        
        [cell.content setFrame:frame];
        [cell addSubview:cell.content];
        [cell layoutIfNeeded];
        
        
        
        
        

        
        contentHeight = cell.content.frame.size.height;
        NSLog(@"size = %f",contentHeight);
        
        CGFloat dif = 16.0f;
        heightArray[indexPath.row] = [NSString stringWithFormat:@"%f",contentHeight+dif];
        [self.tableView reloadData];
        return cell;
    }
   
    
    
    
//    if([obj.type isEqualToString:@"code"]){
//        height2.constant = sizeThatFitsTextView.height;
//    }else{
//        height1.constant = sizeThatFitsTextView.height;
//    }
    
    
    
//    CGRect frame = content.frame;
//    
//    float height = [self getHeightForText:obj.content withFont:content.font andWidth:self.view.frame.size.width-36];
////    float gap = 2;
//    
//    content.frame = CGRectMake(frame.origin.x,
//                                             frame.origin.y,
//                                             self.view.frame.size.width-36,
//                                             height);
//
//    NSLog(@"height = %f",self.view.frame.size.width);
//    [content setText:obj.content];
//
    
//    [content setFrame:CGRectMake(content.frame.origin.x, content.frame.origin.y, self.view.frame.size.width-10, height)];
    
//    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:obj.content];
    
//    NSArray *words=[obj.content componentsSeparatedByString:@"(h)"];
//    
//    for (NSString *word in words) {
//        if ([word hasPrefix:@"@"]) {
//            NSRange range=[obj.content rangeOfString:word];
//            
//            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//            
//            
//        }
//    }
//    
//    
//    NSRange range = [[string string] rangeOfString:@"(h)@"];
//    if(range.location != NSNotFound){
//        [string replaceCharactersInRange:range withString:@""];
//    }
//    NSRange range2 = [[string string] rangeOfString:@"(h)"];
//    if(range2.location != NSNotFound){
//        [string replaceCharactersInRange:range2 withString:@""];
//    }
//    [content setAttributedText:string];

    
    
    
//    content.layer.cornerRadius = 15.0f;
    
//    if([[heightArray objectAtIndex:indexPath.row] isEqualToString:@"44"]){
    
    
    
    return cell;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
