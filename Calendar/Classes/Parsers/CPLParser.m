//
//  CPLParser.m
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "CPLParser.h"
#import "CPLsProvider.h"
#import "CPLs+CoreDataProperties.h"


@implementation CPLParser

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
        CPLsProvider *provider = [[CPLsProvider alloc] init];
        CPLs *cpl = [provider getOrCreateCPLsWithID:rowArray[0]];
        [cpl setTitle:rowArray[1]];
        [cpl setKind:[f numberFromString:rowArray[2]]];
        [cpl setDuration:[f numberFromString:rowArray[3]]];
        [cpl setEditRate_a:[f numberFromString:rowArray[4]]];
        [cpl setEditRate_b:[f numberFromString:rowArray[5]]];
        [cpl setPictureEncoding:[f numberFromString:rowArray[6]]];
        [cpl setPictureWidth:[f numberFromString:rowArray[7]]];
        [cpl setPictureHeight:[f numberFromString:rowArray[8]]];
        [cpl setPictureEncryption:[f numberFromString:rowArray[9]]];
        [cpl setSoundEncoding:[f numberFromString:rowArray[10]]];
        [cpl setSoundChannel:[f numberFromString:rowArray[11]]];
        [cpl setSoundQuantizationBits:[f numberFromString:rowArray[12]]];
        [cpl setSoundEncryption:[f numberFromString:rowArray[13]]];
        [cpl setArchive:[f numberFromString:rowArray[14]]];
        [cpl setRating:[f numberFromString:rowArray[15]]];
        [cpl setSize:[f numberFromString:rowArray[16]]];
        [cpl setCryptoKeyID:rowArray[17]];
        [cpl setSevenOneVersionID:[f numberFromString:rowArray[18]]];
        [cpl setSevenOneVersionTitle:rowArray[19]];
        [cpl setOriginalVersionID:rowArray[20]];
        [cpl setOriginalVersionTitle:rowArray[21]];
        [cpl setStored:rowArray[22]];
        [cpl setIngesting:rowArray[23]];
        [cpl setLastUpdate:[df dateFromString:rowArray[24]]];
        [cpl setValidationCheckFiles:rowArray[25]];
        [cpl setValidationFiles:rowArray[26]];
        [cpl setValidationCheckSize:rowArray[27]];
        [cpl setValidationSize:rowArray[28]];
        //        [program setLastUpdate:rowArray[8]];
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

