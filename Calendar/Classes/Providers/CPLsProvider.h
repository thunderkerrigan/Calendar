//
//  CPLs+Provider.h
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "BaseProvider.h"

@class CPLs;

@interface CPLsProvider : BaseProvider

-(CPLs *)createCPLs;
- (CPLs *)getOrCreateCPLsWithID:(NSString *)stringID;
- (BOOL) deleteCPL:(CPLs *)cpl;


@end
