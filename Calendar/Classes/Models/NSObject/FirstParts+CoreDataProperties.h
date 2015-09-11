//
//  FirstParts+CoreDataProperties.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FirstParts.h"
#import <MDMCoreData/NSManagedObject+MDMCoreDataAdditions.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstParts (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *showTitle;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *screen;
@property (nullable, nonatomic, retain) NSString *compositionPlaylistID;
@property (nullable, nonatomic, retain) NSDate *showPlaylistNotValidBefore;
@property (nullable, nonatomic, retain) NSDate *showPlaylistNotValidAfter;
@property (nullable, nonatomic, retain) NSString *scope;
@property (nullable, nonatomic, retain) NSNumber *is3D;
@property (nullable, nonatomic, retain) NSNumber *is71;
@property (nullable, nonatomic, retain) NSString *idSPL;
@property (nullable, nonatomic, retain) NSDate *lastUpdate;

@end

NS_ASSUME_NONNULL_END
