//
//  SOFService.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

typedef void(^completion)(id result);
typedef void(^contentCompletion)(id result);

typedef void(^errorConnection)(id message);

#define listURL @"http://api.stackexchange.com/2.2/questions?page=%@pagesize=10&order=desc&sort=activity&site=stackoverflow"

#define questionContetURL @"http://api.stackexchange.com/2.1/questions/%@?site=stackoverflow&filter=withbody"

#import <Foundation/Foundation.h>

@interface SOFService : NSObject

+(void)listAllQuestionWithFilter:(NSString *)filter
                            Page:(NSString *)page
                 completeHandler:(void (^)(NSArray *result))completionHandler
                           error:(void (^)(NSString *error))errorCallback;
+(void)getQuestionContentWithQuestionID:(NSString*)questionID
                        completeHandler:(void (^)(NSString *success))completionHandler
                                  error:(void (^)(NSString *error))errorCallback;
@end
