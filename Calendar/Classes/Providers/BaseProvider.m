//
//  BaseProvider.m
//  Calendar
//
//  Created by Joseph on 11/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "BaseProvider.h"
#import "AppDelegate.h"
#import <MDMCoreData/NSManagedObject+MDMCoreDataAdditions.h>

@interface BaseProvider (){
    NSManagedObjectContext *backgroundObjectContext;
}

@end

@implementation BaseProvider


-(instancetype)initWithContext:(NSManagedObjectContext *)context{
    if (self) {
        self = [super init];
        backgroundObjectContext = context;
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!backgroundObjectContext) {
        backgroundObjectContext = [[[NSApp delegate] persistenceController] newPrivateChildManagedObjectContext];
    }
    return backgroundObjectContext;
}

- (BOOL) saveContext {
    __block NSError *error = nil;
    [backgroundObjectContext performBlockAndWait:^{
        if (![backgroundObjectContext save:&error])
        {
            // handle error
        }
        else{
            // save parent to disk asynchronously
            [[[NSApp delegate] persistenceController] saveContextAndWait:NO completion:^(NSError *parentError) {
                error = parentError;
            }];
        }
    }];
    return error == nil;
}

@end
