//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "UserData+CoreDataProperties.h"
#import "Car+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *viewContext = app.persistentContainer.viewContext;
    
    UserData *user;
    
    user = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:viewContext];
    user.iid = @"A01";
    user.cname = @"David";
    
    user = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:viewContext];
    user.iid = @"A02";
    user.cname = @"Lee";
    
    [viewContext save:nil];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:viewContext];
    
    [fetch setEntity:entity];
    
    NSArray *allUsers = [viewContext executeFetchRequest:fetch error:nil];
    for (UserData *p in allUsers)
    {
        NSLog(@"%@, %@", p.iid, p.cname);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
