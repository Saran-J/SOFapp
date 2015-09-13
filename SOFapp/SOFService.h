//
//  SOFService.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//



#define listURL @"http://api.stackexchange.com/2.2/questions?page=%@&pagesize=10&order=desc&sort=activity&site=stackoverflow"

#define questionContetURL @"http://api.stackexchange.com/2.2/questions/%@?site=stackoverflow&filter=withbody"

#define searchURL @"https://api.stackexchange.com/2.2/search?page=%@&pagesize=10&order=desc&sort=activity&intitle=%@&site=stackoverflow"

#import <Foundation/Foundation.h>

@interface SOFService : NSObject

+(void)listAllQuestionOnPage:(NSString *)page
                 completeHandler:(void (^)(NSArray *result,BOOL isLast))completionHandler
                           error:(void (^)(NSString *error))errorCallback;
+(void)getQuestionContentWithQuestionID:(NSString*)questionID
                        completeHandler:(void (^)(NSString *content))completionHandler
                                  error:(void (^)(NSString *error))errorCallback;

+(void)getSearchResultFrom:(NSString*)keyword
                      Page:(NSString *)page
           completeHandler:(void (^)(NSArray *result,BOOL isLast))completionHandler
                     error:(void (^)(NSString *error))errorCallback;

+(id)parseHtmlString:(NSString *)htmlString WithTag:(NSString*)tag;
+(NSString *)convertStringInCodeTagToPlaintext:(NSString *)content;
@end
