//
//  mySQLManager.m
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "mySQLManager.h"
#import "mySQLConnect.h"
#import "mySQLQuery.h"

@interface mySQLManager (){
    mySQLConnect *db;
    mySQLQuery *query;
}

@end

@implementation mySQLManager

+ (mySQLManager *)sharedManager
{
    static mySQLManager *sharedManager;
    
    @synchronized(self)
    {
        if (!sharedManager)
        {
            sharedManager = [[mySQLManager alloc] init];
        }
    }
    return sharedManager;
}

- (id)init{
    db = [[mySQLConnect alloc] init];
    db.socket = nil;
    db.serverName = @"clara.adde.fr";
    db.dbName = @"Phoenix";
    db.userName = @"Joseph";
    db.password = @"password";
    db.port = 3306;
    @try{
        [db connect];
        query = [[mySQLQuery alloc] initWithDatabase:db];
    }
    @catch (NSException *exception) {
        [db errorMessage];
    }
       return self;
}

- (void) tableFromQueryString:(NSString *)queryString
                             doOnSuccess:(SQLManagerOnSuccess)success
                               onFailure:(SQLManagerOnFailure)failure{

    query.sql = queryString;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL queryStatus = [query execQuery];
        if (queryStatus) {
            if(success)
            {
                success([query getResultArray]);
                [self closeConnection];
            }
        } else {
            if(failure) {
                // le paramètre existe, on exécute le block qui traite l'échec
                failure(@"query error");
                [self closeConnection];
            }
        }
    });
}

- (void) closeConnection {
    [db disconnect];
}

@end
