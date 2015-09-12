//
//  SOFService.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "SOFService.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation SOFService

+(void)listAllQuestionWithFilter:(NSString *)filter
                            Page:(NSString *)page
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
@end
