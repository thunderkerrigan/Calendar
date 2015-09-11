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
    for (NSMutableArray *rowArray in array) {
        CPLsProvider *provider = [[CPLsProvider alloc] init];
        CPLs *cpl = [provider getOrCreateCPLsWithID:rowArray[0]];
        [cpl setIdCPL:rowArray[0]];
        [cpl setTitle:rowArray[1]];
        [cpl setKind:rowArray[2]];
        [cpl setDuration:rowArray[3]];
        [cpl setEditRate_a:rowArray[4]];
        [cpl setEditRate_b:rowArray[5]];
        [cpl setPictureEncoding:rowArray[6]];
        [cpl setPictureWidth:rowArray[7]];
        [cpl setPictureHeight:rowArray[8]];
        [cpl setPictureEncryption:rowArray[9]];
        [cpl setSoundEncoding:rowArray[10]];
        [cpl setSoundChannel:rowArray[11]];
        [cpl setSoundQuantizationBits:rowArray[12]];
        [cpl setSoundEncryption:rowArray[13]];
        [cpl setArchive:rowArray[14]];
        [cpl setRating:rowArray[15]];
        [cpl setSize:rowArray[16]];
        [cpl setCryptoKeyID:rowArray[17]];
        [cpl setSevenOneVersionID:rowArray[18]];
        [cpl setSevenOneVersionTitle:rowArray[19]];
        [cpl setOriginalVersionID:rowArray[20]];
        [cpl setOriginalVersionTitle:rowArray[21]];
        [cpl setStored:rowArray[22]];
        [cpl setIngesting:rowArray[23]];
        [cpl setLastUpdate:rowArray[24]];
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

