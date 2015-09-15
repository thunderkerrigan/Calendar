//
//  CalendarManager.h
//  Calendar
//
//  Created by Joseph on 15/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScheduleKit/ScheduleKit.h>

@class Calendar;

@interface CalendarManager : NSObject

- (NSArrayController *) getCurrentWeekCalendarPlanning;
- (NSArrayController *) getCalendarPlanningForWeek:(NSDate *)date;
- (BOOL) setNewDateForSelectedCalendarEvent:(Calendar *)calendar;
- (NSArrayController *) getCalendarPlanningForStartingDate:(NSDate *)beginDate andEndDate:(NSDate *)endDate;
-(NSArray*) arrangedObjects;
@end
