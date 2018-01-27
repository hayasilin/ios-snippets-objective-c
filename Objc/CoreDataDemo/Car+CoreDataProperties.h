//
//  Car+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//
//

#import "Car+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

+ (NSFetchRequest<Car *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *plate;
@property (nullable, nonatomic, retain) UserData *belongto;

@end

NS_ASSUME_NONNULL_END
