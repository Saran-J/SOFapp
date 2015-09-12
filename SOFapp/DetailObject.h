//
//  DetailObject.h
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailObject : NSObject

@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *content;

-(id)initWithType:(NSString *)type Content:(NSString *)content;
@end
