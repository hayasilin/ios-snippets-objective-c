//
//  AppDelegate.h
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

