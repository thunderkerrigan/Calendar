//
//  BaseParser.h
//  Calendar
//
//  Created by Joseph on 09/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParser : NSObject

// définition de l'interface des blocks passés en paramètre
typedef void (^ParserOnSuccess)(void);
typedef void (^ParserOnFailure)(void);

+ (void)parseData:(NSData *)data
      doOnSuccess:(ParserOnSuccess)success
        onFailure:(ParserOnFailure)failure;

+ (void)parseArray:(NSMutableArray *)array
       doOnSuccess:(ParserOnSuccess)success
         onFailure:(ParserOnFailure)failure;

@end
