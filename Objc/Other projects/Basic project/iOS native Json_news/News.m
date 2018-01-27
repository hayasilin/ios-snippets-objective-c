//
//  News.m
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "News.h"

@implementation News

- (void)dealloc{
    self.title = nil;
    self.publisher = nil;
}

- (id)initWithDictionary: (NSDictionary *)newsInfo_{
    self = [super init];
    
    if (self) {
        NSDictionary *newsInfo = newsInfo_;
        NSLog(@"News info = %@", newsInfo);
        
        self.title = [newsInfo valueForKey:@"title"];
        self.publisher = [newsInfo valueForKey:@"publisher"];
    }
    return self;
}



@end
