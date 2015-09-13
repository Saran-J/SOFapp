//
//  MainViewController.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/12/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>;

@property (nonatomic,strong) NSArray *result;

@property (nonatomic,strong) IBOutlet UITableView *tableView;

-(IBAction)onSearch:(id)sender;
@end
