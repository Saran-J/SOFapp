//
//  DetailViewController.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>;

@property (nonatomic,strong) NSArray *result;

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@end
