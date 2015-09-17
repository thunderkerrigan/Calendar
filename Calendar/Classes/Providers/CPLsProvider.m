//
//  CPLs+Provider.m
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "CPLsProvider.h"
#import "CPLs+CoreDataProperties.h"

@interface CPLsProvider ()

@end

@implementation CPLsProvider

#pragma mark - Create Methods

- (CPLs *)createCPLsWithID:(NSString *)stringID{
    CPLs *aCPLs = (CPLs *)[NSEntityDescription insertNewObjectForEntityForName:[CPLs MDMCoreDataAdditionsEntityName] inManagedObjectContext:[self managedObjectContext]];
    [aCPLs setIdCPL:stringID];
    return aCPLs;
}

- (CPLs *)getOrCreateCPLsWithID:(NSString *)stringID {
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[CPLs MDMCoreDataAdditionsEntityName]  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(idCPL MATCHES %@)",stringID]];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects firstObject];
    else
        return [self createCPLsWithID:stringID];
}

#pragma mark - Get Methods

- (NSArray *)getAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSFetchRequest *__request = [[NSFetchRequest alloc] init]; NSEntityDescription *__entity = [NSEntityDescription entityForName:[CPLs MDMCoreDataAdditionsEntityName] inManagedObjectContext:__moc];
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

- (BOOL) deleteCPL:(CPLs *)cpl {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:cpl];
    return [self saveContext];
}

- (BOOL)deleteAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSArray *__allCPLs = [self getAll];
    [__allCPLs enumerateObjectsUsingBlock:^(CPLs *cpl, NSUInteger idx, BOOL *stop) {
        [__moc deleteObject:cpl];
    }];
    return [self saveContext];
}

#pragma mark - update Methods

- (BOOL) updateCPLs{
    return [self saveContext];
}

@end
