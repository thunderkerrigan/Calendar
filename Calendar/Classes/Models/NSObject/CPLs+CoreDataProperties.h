//
//  CPLs+CoreDataProperties.h
//  Calendar
//
//  Created by Joseph on 15/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CPLs.h"
#import <MDMCoreData/NSManagedObject+MDMCoreDataAdditions.h>
#import "Calendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPLs (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *archive;
@property (nullable, nonatomic, retain) NSString *cryptoKeyID;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSNumber *editRate_a;
@property (nullable, nonatomic, retain) NSNumber *editRate_b;
@property (nullable, nonatomic, retain) NSString *idCPL;
@property (nullable, nonatomic, retain) NSString *ingesting;
@property (nullable, nonatomic, retain) NSNumber *kind;
@property (nullable, nonatomic, retain) NSDate *lastUpdate;
@property (nullable, nonatomic, retain) NSString *originalVersionID;
@property (nullable, nonatomic, retain) NSString *originalVersionTitle;
@property (nullable, nonatomic, retain) NSNumber *pictureEncoding;
@property (nullable, nonatomic, retain) NSNumber *pictureEncryption;
@property (nullable, nonatomic, retain) NSNumber *pictureHeight;
@property (nullable, nonatomic, retain) NSNumber *pictureWidth;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSNumber *sevenOneVersionID;
@property (nullable, nonatomic, retain) NSString *sevenOneVersionTitle;
@property (nullable, nonatomic, retain) NSNumber *size;
@property (nullable, nonatomic, retain) NSNumber *soundChannel;
@property (nullable, nonatomic, retain) NSNumber *soundEncoding;
@property (nullable, nonatomic, retain) NSNumber *soundEncryption;
@property (nullable, nonatomic, retain) NSNumber *soundQuantizationBits;
@property (nullable, nonatomic, retain) NSString *stored;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *validationCheckFiles;
@property (nullable, nonatomic, retain) NSString *validationCheckSize;
@property (nullable, nonatomic, retain) NSString *validationFiles;
@property (nullable, nonatomic, retain) NSString *validationSize;
@property (nullable, nonatomic, retain) NSSet<Calendar *> *cplToCalendar;

@end

@interface CPLs (CoreDataGeneratedAccessors)

- (void)addCplToCalendarObject:(Calendar *)value;
- (void)removeCplToCalendarObject:(Calendar *)value;
- (void)addCplToCalendar:(NSSet<Calendar *> *)values;
- (void)removeCplToCalendar:(NSSet<Calendar *> *)values;

@end

NS_ASSUME_NONNULL_END
