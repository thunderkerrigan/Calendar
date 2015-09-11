//
//  ProgramParser.m
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ProgramParser.h"
#import "mySQLConnect.h"
#import "ProgramProvider.h"
#import "Programs+CoreDataProperties.h"




@implementation ProgramParser

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
    for (NSMutableArray *rowArray in array) {
        ProgramProvider *provider = [[ProgramProvider alloc] init];
        Programs *program = [provider getOrCreateProgramWithID:rowArray[0]];
        [program setTitle:rowArray[1]];
        [program setTitle:rowArray[1]];
        [program setXml:rowArray[2]];
        [program setIdCPL:rowArray[3]];
        [program setSoundLevelCPL:rowArray[4]];
        [program setCreditPositionCPL:rowArray[5]];
        [program setTemplate_identifier:rowArray[6]];
        [program setTemplate:rowArray[7]];
        [program setLastUpdate:[NSDate dateWithString:rowArray[8]]];
        [provider saveContext];
        //        XMLProgram = [[NSXMLDocument alloc] initWithXMLString:[[array objectAtIndex:0] objectAtIndex:0] options:0 error:nil];
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
