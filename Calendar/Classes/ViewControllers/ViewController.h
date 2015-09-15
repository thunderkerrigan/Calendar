//
//  ViewController.h
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScheduleKit/ScheduleKit.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource, SCKEventManagerDataSource, SCKEventManagerDelegate, SCKGridViewDelegate>


@end

