//
//  Program+Provider.m
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "Program+Provider.h"
#import "Programs+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation Program_Provider

#pragma mark - CoreData

+ (NSManagedObjectContext *)managedObjectContext
{
    return ((AppDelegate*)[NSApp delegate]).managedObjectContext;
}

+ (BOOL)saveContext {
    NSManagedObjectContext *__moc = [[self class] managedObjectContext];
    if([__moc hasChanges]) {
        NSError *__saveError = nil; if(![__moc save:&__saveError]) {
            NSLog(@"save context error : %@", __saveError);
            return NO; }
    }
    return YES; }
#pragma mark - Create Methods

+ (Programs *)createProgramsWithID:(NSString *)stringID {
    return (Programs *)[NSEntityDescription insertNewObjectForEntityForName:@"Programs" inManagedObjectContext:[self managedObjectContext]];
}

+ (Programs *)getOrCreateCPLWithID:(NSString *)stringID {
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [[self class] managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Programs"  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"(idProgram MATCHES %@)",stringID]];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    
    if([fetchedObjects count] == 1)
        return [fetchedObjects firstObject];
    else
        return [[self class] createProgramsWithID:stringID];
}

#pragma mark - Get Methods

+ (NSArray *)getAll {
    NSManagedObjectContext *__moc = [[self class] managedObjectContext];
    NSFetchRequest *__request = [[NSFetchRequest alloc] init]; NSEntityDescription *__entity = [NSEntityDescription entityForName:@"CDUser" inManagedObjectContext:__moc];
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

+ (BOOL) deleteProgram:(Programs *)program {
    NSManagedObjectContext *context = [[self class] managedObjectContext];
    [context deleteObject:program];
    return [[self class] saveContext];
}
+ (BOOL)deleteAll {
    NSManagedObjectContext *__moc = [self managedObjectContext];
    NSArray *__allPrograms = [[self class] getAll];
    [__allPrograms enumerateObjectsUsingBlock:^(Programs *program, NSUInteger idx, BOOL *stop) {
        [__moc deleteObject:program];
    }];
    return [[self class] saveContext];
}

@end
