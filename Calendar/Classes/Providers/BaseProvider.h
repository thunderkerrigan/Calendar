//
//  BaseProvider.h
//  Calendar
//
//  Created by Joseph on 11/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface BaseProvider : NSObject

- (NSManagedObjectContext *)managedObjectContext;
- (BOOL)saveContext;
- (NSArray *)getAll;
- (BOOL)deleteAll;

@end
