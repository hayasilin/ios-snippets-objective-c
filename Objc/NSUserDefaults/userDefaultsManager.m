//
//  userDefaultsManager.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/3/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "userDefaultsManager.h"

static NSString * const JPGFavoriteUserDefaultsKey = @"favorites";

@interface userDefaultsManager ()

@end

@implementation userDefaultsManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)load{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:JPGFavoriteUserDefaultsKey, self.favorites, nil];
    [userDefaults registerDefaults:defaultValues];
    
    //用以下的判斷避免當第一次開啟App時，因為NSUserDefaults裡面是空的，而把Array設定成nil，造成無法加入資料的問題
    if ([userDefaults objectForKey:JPGFavoriteUserDefaultsKey] != nil) {
        //不能用下面的方法，會直接把一個array丟到favorites裡面，之後加入新物件後會出錯
        //self.favorites = [userDefaults objectForKey:JPGFavoriteUserDefaultsKey];
        
        //如果沒有removeAllObjects，每次load都會重複加入相同的UserDefaults array
        [self.favorites removeAllObjects];
        for (NSString *str in [userDefaults objectForKey:JPGFavoriteUserDefaultsKey]) {
            [self.favorites addObject:str];
        }
    }else{
        //Do nothing
    }
}

- (void)save{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.favorites forKey:JPGFavoriteUserDefaultsKey];
    [userDefaults synchronize];
}

- (void)add:(NSString *)gid{
    if (gid == nil || [gid isEqualToString:@""]) {
        return;
    }
    
    if ([self.favorites containsObject:gid]) {
        [self remove:gid];
    }
    
    [self.favorites addObject:gid];
    [self save];
}

- (void)remove:(NSString *)gid{
    if (gid == nil || [gid isEqualToString:@""]) {
        return;
    }
    
    if ([self.favorites containsObject:gid]) {
        NSLog(@"index = %lu", (unsigned long)[self.favorites indexOfObject:gid]);
        NSUInteger index = [self.favorites indexOfObject:gid];
        [self.favorites removeObjectAtIndex:index];
    }
    
    [self save];
}

- (void)toggle:(NSString *)gid{
    NSLog(@"gid = %@", gid);
    
    if (gid == nil || [gid isEqualToString:@""]) {
        return;
    }
    
    if ([self inFavorites:gid]) {
        [self remove:gid];
    }else{
        [self add:gid];
    }
}

- (BOOL)inFavorites:(NSString *)gid{
    if (gid == nil || [gid isEqualToString:@""]) {
        return nil;
    }
    
    return [self.favorites containsObject:gid];
}

- (void)move:(int)sourceIndex destinationIndex:(int)destinationIndex{
    if (sourceIndex >= self.favorites.count || destinationIndex >= self.favorites.count) {
        return;
    }
    
    NSString *srcGid = self.favorites[sourceIndex];
    [self.favorites removeObjectAtIndex:sourceIndex];
    [self.favorites insertObject:srcGid atIndex:destinationIndex];
}


@end
