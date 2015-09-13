//
//  WebViewQuestionViewController.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/14/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "WebViewQuestionViewController.h"
#import "SOFService.h"

@interface WebViewQuestionViewController ()

@end

@implementation WebViewQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.content = [SOFService convertStringInCodeTagToPlaintext:self.content];
    
    self.content = [self.content stringByReplacingOccurrencesOfString:@"><code" withString:@"><code class='coding'"];
    self.content = [self.content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    NSString *style = @"<style>.coding {float: left;margin: 5px;padding: 15px;width: 320px;word-wrap: break-word;border: 1px solid black;}code {color: #0000ff;}p {margin: 5px} img {max-width:100%; height:auto}</style>";
    NSString *url = [NSString stringWithFormat:@"%@<div>%@</div>",style,self.content];
    [self.web loadHTMLString:url baseURL:[NSURL URLWithString:@"http://www.stackoverflow.com"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ", (int)webView.frame.size.width]];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(UIWebViewNavigationTypeLinkClicked == navigationType /*you can add some checking whether link should be opened in Safari */) {
        
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
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
