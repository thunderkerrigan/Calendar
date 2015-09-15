//
//  CalendarParser.m
//  Calendar
//
//  Created by Joseph on 14/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "CalendarParser.h"
#import "CalendarProvider.h"
#import "CPLsProvider.h"
#import "Calendar+CoreDataProperties.h"

@implementation CalendarParser

+ (void)parseData:(NSData *)data
      doOnSuccess:(ParserOnSuccess)success
        onFailure:(ParserOnFailure)failure {
    // on parse l'objet data
    BOOL __parserDidFail = NO;
    
    
    
    // Quelque chose a fait échouer le parsing
    if(__parserDidFail) {
        // On vérifie que lors de l'appel de la méthode, un paramètre "failure" a été renseigné
        if(failure) {
            // le paramètre existe, on exécute le block qui traite l'échec
            failure();
        }
    }
    // Tout s'est bien passé
    else
    {
        // On vérifie que lors de l'appel de la méthode, un paramètre "success" a été renseigné
        if(success)
        {
            success();
        }
    }
}

+ (void)parseArray:(NSMutableArray *)array
       doOnSuccess:(ParserOnSuccess)success
         onFailure:(ParserOnFailure)failure {
    // on parse l'objet array
    BOOL __parserDidFail = NO;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (NSMutableArray *rowArray in array) {
        CalendarProvider *provider = [[CalendarProvider alloc] init];
        CPLsProvider *cplProvider = [[CPLsProvider alloc] initWithContext:[provider managedObjectContext]];
        Calendar *calendar = [provider getOrCreateCalendarWithID:rowArray[0]];
        [calendar setIdCalendar:rowArray[0]];
        [calendar setDate:[df dateFromString:rowArray[1]]];
        [calendar setRoom:rowArray[2]];
        [calendar setIdCPL:rowArray[3]];
        [calendar setIdSPL:rowArray[4]];
        [calendar setIsPrivate:[f numberFromString:rowArray[5]]];
        [calendar setLastUpdate:[df dateFromString:rowArray[6]]];
        [calendar setEventID:rowArray[7]];
        [calendar setFeatureID:rowArray[8]];
        [calendar setProgramTitle:rowArray[9]];
        CPLs *c = [cplProvider getOrCreateCPLsWithID:calendar.idCPL];
        if (c != nil) {
            [calendar setCalendarToCPL:c];
            [c addCplToCalendarObject:calendar];
        }
        [provider saveContext];
    }
    
    // Quelque chose a fait échouer le parsing
    if(__parserDidFail) {
        // On vérifie que lors de l'appel de la méthode, un paramètre "failure" a été renseigné
        if(failure) {
            // le paramètre existe, on exécute le block qui traite l'échec
            failure();
        }
    }
    // Tout s'est bien passé
    else
    {
        // On vérifie que lors de l'appel de la méthode, un paramètre "success" a été renseigné
        if(success)
        {
            success();
        }
    }
}


@end
