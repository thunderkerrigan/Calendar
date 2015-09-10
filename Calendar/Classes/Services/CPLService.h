//
//  CPLService.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPLService : NSObject

// définition de l'interface des blocks passés en paramètre
typedef void (^ServiceGetCPLOnSuccess)(void);
typedef void (^ServiceGetCPLOnFailure)(int errorCode, NSDictionary
                                         *errorMessages);
- (void)fetchDataDoOnSuccess:(ServiceGetCPLOnSuccess)success
                   onFailure:(ServiceGetCPLOnFailure)failure;
@end
