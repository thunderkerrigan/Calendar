//
//  mySQLQueryManager.m
//  Calendar
//
//  Created by Joseph on 10/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "mySQLQuery.h"
#import "mySQLConnect.h"

@implementation mySQLQuery
@synthesize sql;

- (id)initWithDatabase:(mySQLConnect*)dbase
{
    self = [super init];
    if (self) {
        db = dbase;
        rowsArray = [NSMutableArray array];
    }
    return self;
}

-(BOOL)execQuery
{
    NSLog(@"begin executing query");
    [rowsArray removeAllObjects];
    num_fields = 0;
    if(mysql_query(db.mysql, sql.UTF8String))
        [db mysqlError];
    MYSQL_RES* res = mysql_use_result(db.mysql);
    if(res){
        num_fields = mysql_num_fields(res);
        MYSQL_ROW row;
        while ((row = mysql_fetch_row(res))){
            for(NSInteger i=0;i<num_fields;i++){
                if (row[i]) {
                    NSLog(@" field in %d --> %@", i , [NSString stringWithUTF8String:row[i]]);
                    NSString* sField = [NSString stringWithUTF8String:row[i]];
                    [rowsArray addObject:sField];
                }
            }
        }
        
        mysql_free_result(res);
        return YES;
    }
    else{
        return NO;
    }
}

- (NSInteger)recordCount
{
    NSInteger result;
    if(num_fields){
        result = rowsArray.count / num_fields;
    }
    else
        result = 0;
    return result;
}

- (NSString*)stringValFromRow:(int)row Column:(int)col
{
    NSString* result = nil;
    if(num_fields && col < num_fields){
        NSInteger objidx = row * num_fields + col;
        result = [rowsArray objectAtIndex:objidx];
    }
    return result;
}

- (NSInteger)integerValFromRow:(int)row Column:(int)col
{
    NSString* s = [self stringValFromRow:row Column:col];
    return s.integerValue;
}

- (double)doubleValFromRow:(int)row Column:(int)col
{
    NSString* s = [self stringValFromRow:row Column:col];
    return s.doubleValue;
}

- (NSMutableArray *) getResultArray{
    return rowsArray;
}

@end
