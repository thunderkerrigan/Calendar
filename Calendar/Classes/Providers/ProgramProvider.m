//
//  Program+Provider.m
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ProgramProvider.h"
#import "Programs+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ProgramProvider ()

@property (nonatomic, readonly) NSManagedObjectContext *insertContext;

@end

@implementation ProgramProvider

#pragma mark - Create Methods

-(Programs *)createPrograms{
    return [Programs MDMCoreDataAdditionsInsertNewObjectIntoContext:[self managedObjectContext]];
}

- (Programs *)getOrCreateProgramWithID:(NSString *)stringID {
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[Programs MDMCoreDataAdditionsEntityName]  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(idProgram MATCHES %@)",stringID]];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects firstObject];    
    else
        return [self createPrograms];
}

#pragma mark - Get Methods

- (NSArray *)getAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSFetchRequest *__request = [[NSFetchRequest alloc] init]; NSEntityDescription *__entity = [NSEntityDescription entityForName:[Programs MDMCoreDataAdditionsEntityName] inManagedObjectContext:__moc];
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

- (BOOL) deleteProgram:(Programs *)program {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:program];
    return [self saveContext];
}
- (BOOL)deleteAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSArray *__allPrograms = [self getAll];
    [__allPrograms enumerateObjectsUsingBlock:^(Programs *program, NSUInteger idx, BOOL *stop) {
        [__moc deleteObject:program];
    }];
    return [self saveContext];
}

@end
