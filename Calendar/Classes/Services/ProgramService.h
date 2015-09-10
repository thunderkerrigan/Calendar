//
//  ProgramService.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface ProgramService : BaseService

// définition de l'interface des blocks passés en paramètre
- (void)fetchDataDoOnSuccess:(ServiceOnSuccess)success
                   onFailure:(ServiceOnFailure)failure;
@end
