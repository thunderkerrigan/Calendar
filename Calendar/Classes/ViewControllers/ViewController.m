//
//  ViewController.m
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ViewController.h"
#import "ProgramService.h"

@interface ViewController (){
    IBOutlet NSTextField *statusTextfield;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [statusTextfield setStringValue:@"Connecting to Database"];
    ProgramService *programService = [[ProgramService alloc] init];
    [programService fetchDataDoOnSuccess:^{
        NSLog(@"did Fetch Data with success");
        [statusTextfield setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        [statusTextfield setStringValue:@"Failure"];
    }];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
