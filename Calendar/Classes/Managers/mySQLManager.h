//
//  mySQLManager.h
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mySQLManager : NSObject

typedef void (^SQLManagerOnSuccess)(void);
typedef void (^SQLManagerOnFailure)(NSString *errorMessages);

+ (mySQLManager *)sharedManager;
- (void) tableFromQueryString:(NSString *)queryString
                             doOnSuccess:(SQLManagerOnSuccess)success
                               onFailure:(SQLManagerOnFailure)failure;
- (NSMutableArray *) getResultArrayFromPreviousRequest;

@end
