//
//  Calendar+CoreDataProperties.h
//  Calendar
//
//  Created by Joseph on 15/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Calendar.h"
#import <MDMCoreData/NSManagedObject+MDMCoreDataAdditions.h>
#import "CPLs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Calendar (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *eventID;
@property (nullable, nonatomic, retain) NSString *featureID;
@property (nullable, nonatomic, retain) NSString *idCalendar;
@property (nullable, nonatomic, retain) NSString *idCPL;
@property (nullable, nonatomic, retain) NSString *idSPL;
@property (nullable, nonatomic, retain) NSNumber *isPrivate;
@property (nullable, nonatomic, retain) NSDate *lastUpdate;
@property (nullable, nonatomic, retain) NSString *programTitle;
@property (nullable, nonatomic, retain) NSString *room;
@property (nullable, nonatomic, retain) CPLs *calendarToCPL;

@end

NS_ASSUME_NONNULL_END
