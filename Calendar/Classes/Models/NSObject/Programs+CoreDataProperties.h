//
//  Programs+CoreDataProperties.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Programs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Programs (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idProgram;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *xml;
@property (nullable, nonatomic, retain) NSString *idCPL;
@property (nullable, nonatomic, retain) NSString *soundLevelCPL;
@property (nullable, nonatomic, retain) NSString *creditPositionCPL;
@property (nullable, nonatomic, retain) NSString *template_identifier;
@property (nullable, nonatomic, retain) NSString *template;
@property (nullable, nonatomic, retain) NSDate *lastUpdate;

@end

NS_ASSUME_NONNULL_END
