//
//  BaseService.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

typedef void (^ServiceOnSuccess)(void);
typedef void (^ServiceOnFailure)(int errorCode, NSDictionary
                                           *errorMessages);

@end
