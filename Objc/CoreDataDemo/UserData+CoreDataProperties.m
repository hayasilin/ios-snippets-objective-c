//
//  UserData+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//
//

#import "UserData+CoreDataProperties.h"

@implementation UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserData"];
}

@dynamic iid;
@dynamic cname;
@dynamic own;

@end
