//
//  mySQLQueryManager.h
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class mySQLConnect;

@interface mySQLQuery : NSObject
{
    mySQLConnect* db;
    NSMutableArray* rowsArray;
    NSInteger num_fields;
}
- (id)initWithDatabase:(mySQLConnect*)dbase; // initializer
- (BOOL)execQuery; // execute query with sql
- (NSInteger)recordCount; // return number rows in result query
- (NSString*)stringValFromRow:(int)row Column:(int)col; // return string from row and column col
- (NSInteger)integerValFromRow:(int)row Column:(int)col;//return NSInteger from row and column col
- (double)doubleValFromRow:(int)row Column:(int)col; // return double from row and column col
- (NSMutableArray *) getResultArray;

@property (copy)NSString* sql;

@end
