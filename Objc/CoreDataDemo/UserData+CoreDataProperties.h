//
//  UserData+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Kuan-Wei Lin on 1/21/18.
//  Copyright © 2018 cracktheterm. All rights reserved.
//
//

#import "UserData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *iid;
@property (nullable, nonatomic, copy) NSString *cname;
@property (nullable, nonatomic, retain) NSSet<Car *> *own;

@end

@interface UserData (CoreDataGeneratedAccessors)

- (void)addOwnObject:(Car *)value;
- (void)removeOwnObject:(Car *)value;
- (void)addOwn:(NSSet<Car *> *)values;
- (void)removeOwn:(NSSet<Car *> *)values;

@end

NS_ASSUME_NONNULL_END
