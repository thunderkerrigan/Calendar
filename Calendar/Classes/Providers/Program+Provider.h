//
//  Program+Provider.h
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@class Programs;

@interface Program_Provider : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (BOOL)saveContext;
+ (Programs *)createProgramsWithID:(NSString *)stringID;
+ (Programs *)getOrCreateCPLWithID:(NSString *)stringID;
+ (NSArray *)getAll;
+ (BOOL) deleteProgram:(Programs *)program;
+ (BOOL)deleteAll;


@end
