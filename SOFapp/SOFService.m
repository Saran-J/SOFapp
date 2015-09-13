//
//  SOFService.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "SOFService.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "DetailObject.h"
#import <NSString+HTML.h>

@implementation SOFService

+(void)listAllQuestionOnPage:(NSString *)page
                 completeHandler:(void (^)(NSArray *,BOOL))completionHandler
                           error:(void (^)(NSString *))errorCallback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(listURL,page);
    [manager GET:[NSString stringWithFormat:listURL,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        NSArray *results = [responseObject objectForKey:@"items"];
        BOOL isLast = [[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"has_more"]] isEqualToString:@"1"] ? false : true;
        
        completionHandler(results,isLast);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorMessage = [error localizedDescription];
        errorCallback(errorMessage);
    }];
}

+(void)getQuestionContentWithQuestionID:(NSString *)questionID
                        completeHandler:(void (^)(NSString *))completionHandler
                                  error:(void (^)(NSString *))errorCallback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:questionContetURL,questionID] parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        
        NSArray *results = [responseObject objectForKey:@"items"];
        
        NSDictionary *question = [results objectAtIndex:0];
        
        NSString *content = [question objectForKey:@"body"];
        
        completionHandler(content);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorMessage = [error localizedDescription];
        errorCallback(errorMessage);
    }];
}

+(void)getSearchResultFrom:(NSString *)keyword
                      Page:(NSString *)page
           completeHandler:(void (^)(NSArray *, BOOL))completionHandler
                     error:(void (^)(NSString *))errorCallback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:searchURL,page,keyword];
    NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:encoded parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        NSArray *results = [responseObject objectForKey:@"items"];
        BOOL isLast = [[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"has_more"]] isEqualToString:@"1"] ? false : true;
        
        completionHandler(results,isLast);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorMessage = [error localizedDescription];
        errorCallback(errorMessage);
    }];
}

+(id)parseHtmlString:(NSString *)htmlString WithTag:(NSString*)tag{
    NSScanner* scanner = [NSScanner scannerWithString:htmlString];
    NSMutableArray *paragraphs = [[NSMutableArray alloc] init];
    
    
    
    NSString *startTag = [NSString stringWithFormat:@"<%@",tag];
    NSString *endTag = [NSString stringWithFormat:@"</%@",tag];
    
    
    [scanner scanUpToString:startTag intoString:nil];
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@">" intoString:nil];
        [scanner scanString:@">" intoString:nil];
        NSString * text = nil;
        [scanner scanUpToString:endTag intoString:&text];
        if (text) {
            DetailObject *obj;
            NSString *type = @"";
            if([tag isEqualToString:@"p"]){
                if(text.length > 7){
                    if([[text substringToIndex:7] isEqualToString:@"<acode>"]){
                        text = [text stringByReplacingOccurrencesOfString:@"<acode><code>" withString:@""];
                        text = [text stringByReplacingOccurrencesOfString:@"</code></acode>" withString:@""];
                        type = @"code";
                    }else {
                        text = [text stringByReplacingOccurrencesOfString:@"<acode><code>" withString:@"[code]"];
                        text = [text stringByReplacingOccurrencesOfString:@"</code></acode>" withString:@"[code]"];
                        type = @"content";
                    }
                }else {
                    text = [text stringByReplacingOccurrencesOfString:@"<code>" withString:@"[code]"];
                    text = [text stringByReplacingOccurrencesOfString:@"</code>" withString:@"[code]"];
                    type = @"content";
                }
                
//                text = [text stringByConvertingHTMLToPlainText];
                

                
                obj = [[DetailObject alloc] initWithType:type Content:text];
                
            }
            [paragraphs addObject:obj];
        }
        [scanner scanUpToString:startTag intoString:nil];
    }
    return paragraphs;
}

+(NSString *)convertStringInCodeTagToPlaintext:(NSString *)content
{
    NSLog(@"content = %@",content);
    NSString *newContent = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"(n)"];
    NSMutableArray *texts = [[newContent componentsSeparatedByString:@"<code>"] mutableCopy];
    
    NSLog(@"length2 = %lu",(unsigned long)texts.count);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\<code>(.*?)\\</code>" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    
    for(int i=1;i<texts.count;i++){
        NSString *currentString = [texts objectAtIndex:i];
        
        currentString = [NSString stringWithFormat:@"<code>%@",currentString];
        NSLog(@"currentString = %@",currentString);
        NSArray *myArray = [regex matchesInString:currentString options:0 range:NSMakeRange(0, [currentString length])] ;
        NSLog(@"myarray = %lu",(unsigned long)myArray.count);
        for (NSTextCheckingResult *match in myArray) {
            NSRange matchRange = [match rangeAtIndex:1];
            NSString *newString = [currentString substringWithRange:matchRange];
            
            newString = [newString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
            newString = [newString stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
            NSLog(@"%@",newString);
            currentString = [currentString stringByReplacingCharactersInRange:matchRange withString:newString];
            [texts setObject:currentString atIndexedSubscript:i];
            
        }
    }
    NSString * result = [[texts valueForKey:@"description"] componentsJoinedByString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"(n)" withString:@"\n"];
    return result;
}


@end
