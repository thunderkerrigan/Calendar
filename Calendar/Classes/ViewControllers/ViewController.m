//
//  ViewController.m
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ViewController.h"
#import "ProgramService.h"
#import "CPLService.h"
#import "CalendarService.h"
#import "AppDelegate.h"

@interface ViewController (){
    IBOutlet NSTextField *statusTextfield;
    IBOutlet NSTextField *statusTextfield2;
}

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [statusTextfield setStringValue:@"Connecting to Database for Programs"];
    [statusTextfield2 setStringValue:@"Connecting to Database For CPLs"];

    ProgramService *programService = [[ProgramService alloc] init];
    CPLService *cplService = [[CPLService alloc] init];
    CalendarService *calendarService = [[CalendarService alloc] init];
    
    [programService fetchDataDoOnSuccess:^{
        [statusTextfield setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        [statusTextfield setStringValue:@"Failure"];
    }];
    [cplService fetchDataDoOnSuccess:^{
        [statusTextfield2 setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        [statusTextfield2 setStringValue:@"Failure"];
    }];
    
    [calendarService fetchDataDoOnSuccess:^{
//        [statusTextfield2 setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
//        [statusTextfield2 setStringValue:@"Failure"];
    }];
    
    
    

    
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSManagedObjectContext*)managedObjectContext
{
    return [ [(AppDelegate *)[NSApp delegate] persistenceController] managedObjectContext];
}

#pragma mark - NSTableViewDelegate



#pragma mark - NSTableViewDataSource

@end
