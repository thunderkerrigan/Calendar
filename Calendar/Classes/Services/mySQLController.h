//
//  mySQLController.h
//  Organiseur
//
//  Created by Loys on 26/11/2013.
//
//

#import <Foundation/Foundation.h>
#import <MCPKit/MCPKit.h>


enum {
    mySQLStatusMaster = 1,
    mySQLStatusSlave = 2,
    mySQLStatusSlaveWithSatus = 3,
    mySQLStatusSlaveWithErrorIO = 4,
    mySQLStatusSlaveWithErrorSQL = 5,
    mySQLStatusSlaveWithErrorIOandSQL = 6
};

@interface mySQLController : NSObject
{
    NSXMLDocument *ScreensTableXML;
}

@property (nonatomic, retain, readwrite) NSString *aString;

- (NSMutableArray *)TableFromQueryString:(NSString *)requestType;
- (NSMutableArray *)TableFromQueryString:(NSString *)requestType inDataBase:(int)index;
- (void)QueryString:(NSString *)requestType;
- (void)QueryStringFirstOnly:(NSString *)requestType;
- (void)QueryStringToMaster:(NSString *)requestType;
+ (mySQLController *)sharedController;
- (NSMutableArray *)connectionTable;

- (id)initWithIp:(NSString *)ip Login:(NSString *)login Password:(NSString *)password DataBase:(NSString *)dataBase;
- (void)switchMasterAtIndex:(int)index;
- (NSArray *)RequestMasterSlaveStatusAtIndex:(int)index;
- (NSArray *)GetMasterSlaveStatusAtIndex:(int)index;
- (void)RefreshSlaveStatus;
- (NSXMLDocument *)GetScreenTable;

- (BOOL)isMaster;

@end
