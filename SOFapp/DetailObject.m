//
//  DetailObject.m
//  SOFapp
//
//  Created by Saran  Jantara-amornporn on 9/13/2558 BE.
//  Copyright (c) 2558 Saran  Jantara-amornporn. All rights reserved.
//

#import "DetailObject.h"

@implementation DetailObject

-(id)initWithType:(NSString *)type Content:(NSString *)content
{
    self = [super init];
    if(self){
        self.type = type;
        self.content = content;
    }
    return self;
}
@end
