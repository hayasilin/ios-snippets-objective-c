//
//  Car+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//
//

#import "Car+CoreDataProperties.h"

@implementation Car (CoreDataProperties)

+ (NSFetchRequest<Car *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Car"];
}

@dynamic plate;
@dynamic belongto;

@end
