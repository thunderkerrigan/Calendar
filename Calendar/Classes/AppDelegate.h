//
//  AppDelegate.h
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MDMCoreData/MDMPersistenceController.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) MDMPersistenceController *persistenceController;


@end

