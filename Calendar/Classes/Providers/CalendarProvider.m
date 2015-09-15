//
//  CalendarProvider.m
//  Calendar
//
//  Created by Joseph on 14/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "CalendarProvider.h"
#import "Calendar+CoreDataProperties.h"

@implementation CalendarProvider

-(Calendar *)createCalendar{
    return (Calendar *)[NSEntityDescription insertNewObjectForEntityForName:[Calendar MDMCoreDataAdditionsEntityName] inManagedObjectContext:[self managedObjectContext]];
}

- (Calendar *)getOrCreateCalendarWithID:(NSString *)stringID{
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[Calendar MDMCoreDataAdditionsEntityName]  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(idCalendar MATCHES %@)",stringID]];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects firstObject];
    else
        return [self createCalendar];

}

#pragma mark - Get Methods

- (NSArray *)getAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSFetchRequest *__request = [[NSFetchRequest alloc] init]; NSEntityDescription *__entity = [NSEntityDescription entityForName:[Calendar MDMCoreDataAdditionsEntityName] inManagedObjectContext:__moc];
    [__request setEntity:__entity];
    NSError *__requestError = nil;
    NSArray *__results = [__moc executeFetchRequest:__request error:&__requestError];
    if(__requestError) {
        NSLog(@"request error : %@", __requestError);
        return nil;
    }
    return __results;
}

#pragma mark - Delete Methods

- (BOOL) deleteCalendar:(Calendar *)calendar{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:calendar];
    return [self saveContext];
}

- (BOOL)deleteAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSArray *__allCPLs = [self getAll];
    [__allCPLs enumerateObjectsUsingBlock:^(Calendar *cpl, NSUInteger idx, BOOL *stop) {
        [__moc deleteObject:cpl];
    }];
    return [self saveContext];
}

#pragma mark - update Methods

- (BOOL) updateCalendars{
    return [self saveContext];
}

@end
