//
//  WebViewQuestionViewController.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/14/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewQuestionViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) IBOutlet UIWebView *web;
@end
