//
//  CalendarProvider.h
//  Calendar
//
//  Created by Joseph on 14/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "BaseProvider.h"
#import <ScheduleKit/ScheduleKit.h>

@class Calendar;

@interface CalendarProvider : BaseProvider

-(Calendar *)createCalendarWithID:(NSString *)stringID;
- (Calendar *)getOrCreateCalendarWithID:(NSString *)stringID;
- (BOOL) deleteCalendar:(Calendar *)calendar;
- (BOOL) updateCalendars;

@end
