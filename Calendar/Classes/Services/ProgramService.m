//
//  ProgramService.m
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ProgramService.h"
#import "mySQLController.h"
#import "ProgramParser.h"

@implementation ProgramService

- (void)fetchDataDoOnSuccess:(ServiceOnSuccess)success
                   onFailure:(ServiceOnFailure)failure
{
    // on appelle le service via la méthode à la mode
    // via AFNetworking par exemple
    // ou à la main avec NSURLConnection si on est un warrior
    // On parse notre objet Data
    NSString *requestType = @"select * from Programs where XML is not null and `Template` = b'0';";
    NSMutableArray *programArray = [[mySQLController sharedController] TableFromQueryString:requestType];
    [ProgramParser parseArray:programArray
             doOnSuccess:^{
                 // Tout s'est bien passé
                 // On vérifie que lors de l'appel de la méthode, un paramètre "success" a été renseigné
                 if(success) {
                     // le paramètre existe, on exécute le block qui traite le succès
                     success();
                 }
             } onFailure:^{
                 // Au contraire, il y a eu une erreur
                 // On vérifie que lors de l'appel de la méthode, un paramètre "failure" a été renseigné
                 if(failure)
                 {
                     // le paramètre existe, on exécute le block qui traite l'échec la signature du block:
                     // on lui passe les paramètres tels que défini dans // typedef void (^ServiceGetUsersOnFailure)(int errorCode, NSDictionary *errorMessages);
                     int __errorCode = 18;
                     NSDictionary *__errorMessages = @{ @"public_message": @"Une erreur s'est produite.",
                                                        @"technical_message": @"La requête a expiré." }; failure(__errorCode, __errorMessages);
                 }
             }];
}

@end
