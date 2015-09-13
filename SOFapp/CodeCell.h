//
//  CodeCell.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeCell : UITableViewCell

@property (nonatomic,strong) IBOutlet NSLayoutConstraint *height;
@property (nonatomic,strong) UILabel *content;

@property (nonatomic,strong) IBOutlet UIView *bg;
@end
