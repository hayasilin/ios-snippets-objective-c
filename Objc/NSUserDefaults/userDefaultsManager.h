//
//  userDefaultsManager.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/3/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userDefaultsManager : NSObject

@property (strong, nonatomic) NSMutableArray *favorites;

+ (instancetype)sharedInstance;

- (void)load;
- (void)save;
- (void)add:(NSString *)gid;
- (void)remove:(NSString *)gid;
- (void)toggle:(NSString *)gid;
- (BOOL)inFavorites:(NSString *)gid;
- (void)move:(int)sourceIndex destinationIndex:(int)destinationIndex;

@end
