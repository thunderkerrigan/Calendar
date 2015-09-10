//
//  mySQLController.m
//  Organiseur
//
//  Created by Loys on 26/11/2013.
//
//

#import "mySQLController.h"


@interface mySQLController()

@property (nonatomic, retain, readwrite) MCPConnection *theConnection;
@property (nonatomic, retain, readwrite) NSMutableArray *theConnectionTable;
@property (nonatomic, retain, readwrite) NSMutableArray *theStatusConnectionTable;

@end

@implementation mySQLController

+ (mySQLController *)sharedController
{
    static mySQLController *sharedController;
    
    @synchronized(self)
    {
        if (!sharedController)
        {
            sharedController = [[mySQLController alloc] init];
        }
        else
        {
            BOOL reinit = NO;
            /*
            int i;
            for (i = 0; i < [[sharedController connectionTable] count]; i++)
            {
                if (![[[sharedController connectionTable] objectAtIndex:i] isConnected])
                {
                    //sharedController = [[mySQLController alloc] init];
                    reinit = YES;
                }
            }
             */
            if (![[[sharedController connectionTable] objectAtIndex:0] isConnected])
            {
                reinit = YES;
            }
            if (reinit)
                sharedController = [[mySQLController alloc] init];
            
        }
    }
    
    return sharedController;
}

-(id)init
{
    
    self  = [super init];
    _theConnectionTable = [[NSMutableArray alloc] init];
    _theStatusConnectionTable = [[NSMutableArray alloc] init];
    ScreensTableXML = [[NSXMLDocument alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] localizedStringForKey:@"ScreensTablePath" value:nil table:nil]] options:0 error:nil];
    NSArray *Sites = [[ScreensTableXML rootElement] elementsForName:@"Site"];
    int i;
    for(i = 0; i < [Sites count]; i++)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MCPConnection *aConnection = [[MCPConnection alloc] initToHost:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue]
                                                             withLogin:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Login"] objectAtIndex:0] stringValue]
                                                             usingPort:3306];
        [aConnection setPassword:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Password"] objectAtIndex:0] stringValue]];
        aConnection.connectionTimeout = 5;
        if([aConnection connect])
            printf("mySQL Connected for: %s\n",[[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue] UTF8String]);
        else
            printf("mySQL NOT Connected for: %s\n",[[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue] UTF8String]);
        
        [aConnection selectDB:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"DataBase"] objectAtIndex:0] stringValue]];
        
        [_theConnectionTable addObject:aConnection];
        [_theStatusConnectionTable addObject:[self RequestMasterSlaveStatusAtIndex:i]];
        });
    }
    if ([_theConnectionTable objectAtIndex:0] != 0)
    _theConnection = [_theConnectionTable objectAtIndex:0];
    /*
    _theConnection = [[MCPConnection alloc] initToHost:@"127.0.0.0" withLogin:@"Cabine" usingPort:3306];
    [_theConnection setPassword: @"password"];
    [_theConnection connect];
    [_theConnection selectDB:@"Phoenix"];
     */
    return  self;
}

- (void)dealloc
{
    [_theConnection disconnect];
}

- (id)initWithIp:(NSString *)ip Login:(NSString *)login Password:(NSString *)password DataBase:(NSString *)dataBase
{
    self  = [super init];
    _theConnection = [[MCPConnection alloc] initToHost:ip withLogin:login usingPort:3306];
    [_theConnection setPassword:password];
    [_theConnection connect];
    [_theConnection selectDB:dataBase];
    return  self;
}

- (NSMutableArray *)TableFromQueryString:(NSString *)requestType
{
        printf("Request: \"%s\"\n",[requestType UTF8String]);
        MCPResult *resultType = [[MCPResult alloc] init];
        
        resultType = [[_theConnectionTable objectAtIndex:0] queryString:requestType];
        NSArray *rowType = [[NSArray alloc]init];
        NSMutableArray *tableToReturn = [[NSMutableArray alloc] init];
        while ((rowType = [resultType fetchRowAsArray]))
        {
            [tableToReturn addObject:rowType];
        }
        return tableToReturn;
}




- (NSMutableArray *)TableFromQueryString:(NSString *)requestType ToConnection:(MCPConnection *)aConnection
{
    //printf("Request: \"%s\"\n",[requestType UTF8String]);
    MCPResult *resultType = [[MCPResult alloc] init];
    
    resultType = [aConnection queryString:requestType];
    NSArray *rowType = [[NSArray alloc]init];
    NSMutableArray *tableToReturn = [[NSMutableArray alloc] init];
    while ((rowType = [resultType fetchRowAsArray]))
    {
        [tableToReturn addObject:rowType];
    }
    return tableToReturn;
}

- (NSMutableArray *)TableFromQueryString:(NSString *)requestType inDataBase:(int)index
{
    //printf("Request: \"%s\"\n",[requestType UTF8String]);
    MCPResult *resultType = [[MCPResult alloc] init];
    
    resultType = [[_theConnectionTable objectAtIndex:index] queryString:requestType];
    NSArray *rowType = [[NSArray alloc]init];
    NSMutableArray *tableToReturn = [[NSMutableArray alloc] init];
    while ((rowType = [resultType fetchRowAsArray]))
    {
        [tableToReturn addObject:rowType];
    }
    return tableToReturn;
}

- (void)QueryString:(NSString *)requestType
{
    printf("Request: \"%s\"\n",[requestType UTF8String]);
    [self QueryStringFirstOnly:requestType];
    return;
    int i;
    for(i = 0; i < [_theConnectionTable count]; i++)
    {
        //printf("Query: %d\n",i);
        [[_theConnectionTable objectAtIndex:i] queryString:requestType];
    }
}

- (void)QueryStringFirstOnly:(NSString *)requestType
{

        [[_theConnectionTable objectAtIndex:0] queryString:requestType];
    
}

- (void)QueryStringToMaster:(NSString *)requestType
{
    printf("RequestToMaster: \"%s\"\n",[requestType UTF8String]);
    int i;
    for(i = 0; i < [_theConnectionTable count]; i++)
    {
        if ([[[_theStatusConnectionTable objectAtIndex:i] objectAtIndex:0] intValue] == mySQLStatusMaster)
        {
            [[_theConnectionTable objectAtIndex:i] queryString:requestType];
            break;
        }
    }
}

- (NSMutableArray *)connectionTable
{
    return _theConnectionTable;
}

- (void)CheckAllAndReInit
{
    int i;
    BOOL reinit = NO;
    for (i = 0; i < [_theConnectionTable count]; i++)
    {
        if (![[_theConnectionTable objectAtIndex:i] isConnected])
        {
            reinit = YES;
        }
    }
    if (reinit)
    {
        NSArray *Sites = [[ScreensTableXML rootElement] elementsForName:@"Site"];
        [_theConnectionTable removeAllObjects];
        [_theStatusConnectionTable removeAllObjects];
        for(i = 0; i < [Sites count]; i++)
        {
            MCPConnection *aConnection = [[MCPConnection alloc] initToHost:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue]
                                                                 withLogin:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Login"] objectAtIndex:0] stringValue]
                                                                 usingPort:3306];
            [aConnection setPassword:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Password"] objectAtIndex:0] stringValue]];
            aConnection.connectionTimeout = 30;
            if([aConnection connect])
                printf("mySQL Connected for: %s\n",[[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue] UTF8String]);
            else
                printf("mySQL NOT Connected for: %s\n",[[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue] UTF8String]);
            
            [aConnection selectDB:[[[[[[Sites objectAtIndex:i] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"DataBase"] objectAtIndex:0] stringValue]];
            
            [_theConnectionTable addObject:aConnection];
            [_theStatusConnectionTable addObject:[self RequestMasterSlaveStatusAtIndex:i]];
        }
        if ([_theConnectionTable objectAtIndex:0] != 0)
            _theConnection = [_theConnectionTable objectAtIndex:0];
    }
}

- (void)switchMasterAtIndex:(int)index
{
    printf("Start SwitchMasterAtIndex\n");
    [self CheckAllAndReInit];
    NSArray *Sites = [[ScreensTableXML rootElement] elementsForName:@"Site"];
    int i;
    
    
    
    NSMutableArray *ReplicationTable = _theConnectionTable;
    
    //printf("STOP SLAVE;\n");
    
    for(i = 0; i < [Sites count]; i++)
    {
        if([[ReplicationTable objectAtIndex:i] isConnected])
        {
            //printf("isConnected\n");
            [[ReplicationTable objectAtIndex:i] queryString:@"STOP SLAVE;"];
            //printf("%s\n",[[[ReplicationTable objectAtIndex:i] getLastErrorMessage] UTF8String]);
        }
    }
    //printf("RESET SLAVE;\n");
    for(i = 0; i < [Sites count]; i++)
    {
        if([[ReplicationTable objectAtIndex:i] isConnected])
        {
            //printf("isConnected\n");
            [[ReplicationTable objectAtIndex:i] queryString:@"RESET SLAVE;"];
            //printf("%s\n",[[[ReplicationTable objectAtIndex:i] getLastErrorMessage] UTF8String]);
        }
    }
    
    //printf("RESET MASTER;\n");
    for(i = 0; i < [Sites count]; i++)
    {
        if([[ReplicationTable objectAtIndex:i] isConnected])
        {
            [[ReplicationTable objectAtIndex:i] queryString:@"RESET MASTER;"];
            //printf("%s\n",[[[ReplicationTable objectAtIndex:i] getLastErrorMessage] UTF8String]);
        }
    }
    
    if (index != -1)
    {
        NSString *aString = [NSString stringWithFormat:@"CHANGE MASTER TO MASTER_HOST='%@', MASTER_PORT=3306, MASTER_USER='ReplicationS', MASTER_PASSWORD='ReplicationSlave';",[[[[[[Sites objectAtIndex:index] elementsForName:@"DataBaseServer"] objectAtIndex:0] elementsForName:@"Ip"] objectAtIndex:0] stringValue]];
        //printf("%s\n",[aString UTF8String]);
        for(i = 0; i < [Sites count]; i++)
        {
            if (i != index)
                if([[ReplicationTable objectAtIndex:i] isConnected])
                {
                    [[ReplicationTable objectAtIndex:i] queryString:aString];
                    //printf("%s\n",[[[ReplicationTable objectAtIndex:i] getLastErrorMessage] UTF8String]);
                }
        }
        //printf("START SLAVE;\n");
        for(i = 0; i < [Sites count]; i++)
        {
            if (i != index)
                if([[ReplicationTable objectAtIndex:i] isConnected])
                {
                    [[ReplicationTable objectAtIndex:i] queryString:@"START SLAVE;"];
                    //printf("%s\n",[[[ReplicationTable objectAtIndex:i] getLastErrorMessage] UTF8String]);
                }
        }
    }
    printf("End SwitchMasterAtIndex\n");
    
    
}

- (NSArray *)RequestMasterSlaveStatusAtIndex:(int)index;
{
    
    MCPConnection *aConnection = [_theConnectionTable objectAtIndex:index];
    
    
    MCPResult *resultType = [aConnection queryString:@"SHOW SLAVE STATUS;"];
    NSArray *rowType = [[NSArray alloc]init];
    NSMutableArray *tableToReturn = [[NSMutableArray alloc] init];
    while ((rowType = [resultType fetchRowAsArray]))
    {
        [tableToReturn addObject:rowType];
    }
    
    int status = -1;
    /*
     int j;
        for (j = 0; j < [[tableToReturn objectAtIndex:0] count]; j++)
        {
            if (![[[tableToReturn objectAtIndex:0] objectAtIndex:j] isKindOfClass:[NSNull class]])
                printf("%d|%s|%s|\n",j,[[[resultType fetchFieldNames] objectAtIndex:j] UTF8String],[[[tableToReturn objectAtIndex:0] objectAtIndex:j] UTF8String]);
        }
    */
    
    if ([tableToReturn count] == 0)
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:mySQLStatusMaster],@"",@"",@"",@"", nil];
    
    if (![[[tableToReturn objectAtIndex:0] objectAtIndex:0] isEqualToString:@""])
    {
        //printf("Slave Of %s\n",[[[tableToReturn objectAtIndex:0] objectAtIndex:1] UTF8String]);
        if ([[[tableToReturn objectAtIndex:0] objectAtIndex:10] isEqualToString:@"Yes"]
            &&
            [[[tableToReturn objectAtIndex:0] objectAtIndex:11] isEqualToString:@"Yes"])
        {
            status = mySQLStatusSlave;
            if ([[[tableToReturn objectAtIndex:0] objectAtIndex:0] isEqualToString:@"Waiting for master to send event"])
            {
                //printf(" OK\n");
            }
            else
            {
                //printf("with status: %s\n",[[[tableToReturn objectAtIndex:0] objectAtIndex:0] UTF8String]);
                status = mySQLStatusSlaveWithSatus;
            }
        }
        else
        {
            
            if (![[[tableToReturn objectAtIndex:0] objectAtIndex:10] isEqualToString:@"Yes"])
            {
                //printf(" with error: %s\n",[[[tableToReturn objectAtIndex:0] objectAtIndex:35] UTF8String]);
                status = mySQLStatusSlaveWithErrorIO;
            }
            if (![[[tableToReturn objectAtIndex:0] objectAtIndex:11] isEqualToString:@"Yes"])
            {
                //printf(" with error: %s\n",[[[tableToReturn objectAtIndex:0] objectAtIndex:37] UTF8String]);
                if (status == mySQLStatusSlaveWithErrorIO)
                    status = mySQLStatusSlaveWithErrorIOandSQL;
                else
                    status = mySQLStatusSlaveWithErrorSQL;
            }
            //printf("\n");
        }
    }
    else
    {
        //printf("Master\n");
        status = mySQLStatusMaster;
    }
        
    if (status == -1)
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:status],@"",@"",@"",@"", nil];
    
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:status],[[tableToReturn objectAtIndex:0] objectAtIndex:0],[[tableToReturn objectAtIndex:0] objectAtIndex:1],[[tableToReturn objectAtIndex:0] objectAtIndex:35],[[tableToReturn objectAtIndex:0] objectAtIndex:37], nil];
}

- (void)RefreshSlaveStatus
{
    [self CheckAllAndReInit];
    int i;
    for (i = 0;i < [_theStatusConnectionTable count]; i++)
    {
        [_theStatusConnectionTable replaceObjectAtIndex:i withObject:[self RequestMasterSlaveStatusAtIndex:i]];
    }
}

- (NSArray *)GetMasterSlaveStatusAtIndex:(int)index
{
    return [_theStatusConnectionTable objectAtIndex:index];
}


- (BOOL)isMaster
{
    if ([[[_theStatusConnectionTable objectAtIndex:0] objectAtIndex:0] intValue] != mySQLStatusMaster)
        return NO;
    for (int i = 1; i < [_theStatusConnectionTable count]; i++)
    {
        if ([[[_theStatusConnectionTable objectAtIndex:i] objectAtIndex:0] intValue] != mySQLStatusSlave)
            return NO;
    }
    return YES;
}

- (NSXMLDocument *)GetScreenTable
{
    return ScreensTableXML;
}

@end


