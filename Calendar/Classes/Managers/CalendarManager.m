//
//  CalendarManager.m
//  Calendar
//
//  Created by Joseph on 15/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "CalendarManager.h"
#import "AppDelegate.h"
#import "CalendarProvider.h"
#import "Calendar+SCKEvent.h"
#import <NSDate+Calendar.h>
#import <ScheduleKit/ScheduleKit.h>

@interface CalendarManager (){
    CalendarProvider *provider;
    NSArrayController *calendarController;
    Calendar *selectedCalendar;
}

@end

@implementation CalendarManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        calendarController = [[NSArrayController alloc] init];
        [calendarController setManagedObjectContext:[[[NSApp delegate] persistenceController] managedObjectContext]];
        [calendarController setEntityName:[Calendar MDMCoreDataAdditionsEntityName]];
        NSError *err;
        [calendarController fetchWithRequest:nil merge:YES error:&err];
        provider = [[CalendarProvider alloc] init];
        
    }
    return self;
}

#pragma mark - manager methods

- (NSArrayController *) getCurrentWeekCalendarPlanning{
    return [self getCalendarPlanningForWeek:[[NSDate date] dateByAddingDays:-10]];
}

- (NSArrayController *) getCalendarPlanningForWeek:(NSDate *)date{
    NSLog(@"current number of Objects: %ld", [[calendarController arrangedObjects] count]);
    NSLog(@"preparing array controller for objects between: %@ and %@", [date dateYesterday], [date dateTomorrow]);
    [calendarController setFilterPredicate:[NSPredicate predicateWithFormat:@"(date > %@ AND date < %@)",[date dateYesterday], [date dateTomorrow]]];
    [calendarController rearrangeObjects];
    NSLog(@"number of Objects after filter: %ld", [[calendarController arrangedObjects] count]);
    
    return calendarController;
}

- (NSArrayController *) getCalendarPlanningForStartingDate:(NSDate *)beginDate andEndDate:(NSDate *)endDate{
    NSLog(@"current number of Objects: %ld", [[calendarController arrangedObjects] count]);
    NSLog(@"preparing array controller for objects between: %@ and %@", beginDate, endDate);
    [calendarController setFilterPredicate:[NSPredicate predicateWithFormat:@"(date > %@ AND date < %@)",beginDate, endDate]];
    [calendarController rearrangeObjects];
    NSLog(@"number of Objects after filter: %ld", [[calendarController arrangedObjects] count]);
    
    return calendarController;
}

- (BOOL) setNewDateForSelectedCalendarEvent:(Calendar *)calendar{
    //TODO
    return YES;
}

-(NSArray*) arrangedObjects{
    return calendarController.arrangedObjects;
}

@end
