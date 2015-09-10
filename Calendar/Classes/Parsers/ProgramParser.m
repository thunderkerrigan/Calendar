//
//  ProgramParser.m
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ProgramParser.h"
#import "mySQLConnect.h"




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
    for (int i = 0; i > [array count]; i++) {
        NSLog(@"object : %@", array[i]);
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
