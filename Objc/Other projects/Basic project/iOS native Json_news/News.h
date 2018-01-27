//
//  News.h
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *publisher;

- (id)initWithDictionary: (NSDictionary *)newsInfo_;

@end
