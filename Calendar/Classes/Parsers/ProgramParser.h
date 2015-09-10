//
//  ProgramParser.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseParser.h"

@interface ProgramParser : BaseParser

+ (void)parseData:(NSData *)data
      doOnSuccess:(ParserOnSuccess)success
        onFailure:(ParserOnFailure)failure;

+ (void)parseArray:(NSMutableArray *)array
      doOnSuccess:(ParserOnSuccess)success
        onFailure:(ParserOnFailure)failure;
@end
