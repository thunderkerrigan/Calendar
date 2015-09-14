//
//  Program+Provider.h
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "BaseProvider.h"

@class Programs;

@interface ProgramProvider : BaseProvider

-(Programs *)createPrograms;
- (Programs *)getOrCreateProgramWithID:(NSString *)stringID;
- (BOOL) deleteProgram:(Programs *)program;


@end
