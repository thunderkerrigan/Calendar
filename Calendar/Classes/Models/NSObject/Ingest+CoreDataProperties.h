//
//  Ingest+CoreDataProperties.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Ingest.h"
#import <MDMCoreData/NSManagedObject+MDMCoreDataAdditions.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ingest (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *idIngest;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *contentType;
@property (nullable, nonatomic, retain) NSData *contentID;
@property (nullable, nonatomic, retain) NSString *contentTitle;
@property (nullable, nonatomic, retain) NSString *sourceID;
@property (nullable, nonatomic, retain) NSString *destinationID;
@property (nullable, nonatomic, retain) NSDate *scheduleTime;
@property (nullable, nonatomic, retain) NSNumber *isDone;
@property (nullable, nonatomic, retain) NSString *issuer;
@property (nullable, nonatomic, retain) NSDate *neededTime;

@end

NS_ASSUME_NONNULL_END
