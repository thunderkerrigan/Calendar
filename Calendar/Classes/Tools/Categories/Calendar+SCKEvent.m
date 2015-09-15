//
//  Calendar+SCKEvent.m
//  Calendar
//
//  Created by Joseph on 15/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "Calendar+SCKEvent.h"

@implementation Calendar (SCKEventCategory)

#pragma mark - SCKEvent delegate

/**
 *  This method or property should return an event type that will be used to draw
 *  SCKEventView's background when color mode is set to 'by event type'
 *  @return The requested SCKEventType value
 */
- (SCKEventType)eventType{
    return self.isPrivate ? SCKEventTypeSpecial : SCKEventTypeDefault;
}

/**
 *  This method or property should return the user object associated with the event,
 *  that is, the event's owner.
 *  @return The requested user object. It must conform to the @c SCKUser protocol.
 */
- (id <SCKUser>)user{
    return nil;
}

/**
 *  This method or property should return the patient object associated with the event
 *  if any. It's not being used at the time.
 *  @return The patient object.
 */
//- (id)patient;

/**
 *  This method or property should return the string that will be drawn inside of the
 *  SCKEventView's frame, which allows the user to better identify each event.
 *  @return The requested NSString object.
 */
- (NSString*)title{
    return [self programTitle]?[self programTitle]:[NSString stringWithFormat:@"SEANCE DE %@",[self date]];
}

/**
 *  Returns the event's duration in minutes.
 *  @return A NSNumber object representing the event duration in minutes.
 */
- (NSNumber*)duration{
    return [NSNumber numberWithInt:60];
}

/**
 *  Called to set the event's duration.
 *  @param duration The new event duration in minutes.
 */
- (void)setDuration:(NSNumber*)duration{
    //TODO
}

/**
 *  Returns the event's date and time.
 *  @return A NSDate object representing the event's start date.
 */
- (NSDate*)scheduledDate{
    NSLog(@"date : %@", [self date]);
    return [self date];
}

/**
 *  Called to set the event's start date.
 *  @param scheduledDate The new event's start date.
 */
- (void)setScheduledDate:(NSDate*)scheduledDate{
//    [self setDate:scheduledDate];
//    [provider updateCalendars];
}


@end
