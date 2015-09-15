//
//  AppDelegate.m
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "fr.ADDE.Calendar" in the user's Application Support directory.
    NSURL *appSupportURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"fr.ADDE.Calendar"];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    // Save changes in the application's managed object context before the application terminates.
    
    if (!self.persistenceController) {
        return NSTerminateNow;
    }
    
    if (![self.persistenceController.managedObjectContext commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![self.persistenceController.managedObjectContext hasChanges]) {
        return NSTerminateNow;
    }
    

    [self.persistenceController saveContextAndWait:YES completion:^(NSError *error) {
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            //        return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertFirstButtonReturn) {
            //        return NSTerminateCancel;
        }
    }];

    return NSTerminateNow;
}

#pragma mark - Persistence Controller

- (MDMPersistenceController *)persistenceController {
    
    if (_persistenceController == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CalendarModel" withExtension:@"momd"];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CalendarModel.sqlite"];
        _persistenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeURL modelURL:modelURL];
        
        if (_persistenceController == nil) {
            
            NSLog(@"ERROR: Persistence controller could not be created");
        }
    }
    
    return _persistenceController;
}


@end
