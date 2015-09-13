//
//  SearchViewController.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) NSArray *result;

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) IBOutlet UISearchBar *search;

@end
