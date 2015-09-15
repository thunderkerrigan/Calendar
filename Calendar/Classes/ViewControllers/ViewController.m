//
//  ViewController.m
//  Calendar
//
//  Created by Joseph on 08/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import "ViewController.h"
#import "ProgramService.h"
#import "CPLService.h"
#import "CalendarService.h"
#import "AppDelegate.h"
#import "CalendarManager.h"
#import <NSDate+Calendar.h>
#import "ProgramProvider.h"
#import "CPLsProvider.h"
#import "CalendarProvider.h"

@interface ViewController (){
    IBOutlet NSTextField *statusTextfield;
    IBOutlet NSTextField *statusTextfield2;
    IBOutlet NSTextField *dateTextfield;
    BOOL _reloadingDayData;
    CalendarManager* calendarManager;
}

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (weak) IBOutlet SCKEventManager * dayEventManager;
@property (weak) IBOutlet NSArrayController * dayEventArrayController;
@property (nonatomic, strong) NSDate *currentDisplayedDate;

-(IBAction)previousDay:(id)sender;
-(IBAction)nextDay:(id)sender;
-(IBAction)deleteAll:(id)sender;
-(IBAction)addAll:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCurrentDisplayedDate:[NSDate date]];
    calendarManager = [[CalendarManager alloc] init];
    [self setDateForEventManager];
    _dayEventManager.dataSource = self;
    _dayEventManager.delegate = self;
//    [_dayEventManager reloadData];
    [(SCKGridView*)_dayEventManager.view setDelegate:self];
    
    [statusTextfield setStringValue:@"Connecting to Database for Programs"];
    [statusTextfield2 setStringValue:@"Connecting to Database For CPLs"];
    
    [self addAll:self];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSManagedObjectContext*)managedObjectContext
{
    return [ [(AppDelegate *)[NSApp delegate] persistenceController] managedObjectContext];
}

#pragma mark - NSTableViewDelegate



#pragma mark - NSTableViewDataSource

#pragma mark - SCKEventManager Data Source

- (NSArray *)eventManager:(SCKEventManager *)eM requestsEventsBetweenDate:(NSDate *)sD andDate:(NSDate *)eD {
//    if (eM == _dayEventManager) {
        _reloadingDayData = YES;
        [calendarManager getCalendarPlanningForStartingDate:sD andEndDate:eD];
//        _dayEventArrayController.filterPredicate = [NSPredicate predicateWithFormat:@"date BETWEEN %@",@[sD,eD]];
//        [_dayEventArrayController rearrangeObjects];
        _reloadingDayData = NO;
        NSLog(@"DayEventManager: %lu events",[[calendarManager getCalendarPlanningForStartingDate:sD andEndDate:eD].arrangedObjects count]);
        return [calendarManager arrangedObjects];
//    } else {
//        _reloadingWeekData = YES;
//        _weekEventArrayController.filterPredicate = [NSPredicate predicateWithFormat:@"scheduledDate BETWEEN %@",@[sD,eD]];
//        [_weekEventArrayController rearrangeObjects];
//        _reloadingWeekData = NO;
//        NSLog(@"WeekEventManager: %lu events",[_weekEventArrayController.arrangedObjects count]);
//        return _weekEventArrayController.arrangedObjects;
//    }
}

- (void)eventManager:(SCKEventManager *)eM didMakeEventRequest:(SCKEventRequest*)request {
//    if (eM == _weekEventManager) {
//        self->_reloadingWeekData = YES;
//        _asynchronousRequest = request;
//        if (!_eventLoadingView) {
//            _eventLoadingView = [[EventLoadingView alloc] initWithFrame:_weekViewHostingView.bounds];
//            
//        }
//        [_weekViewHostingView addSubview:_eventLoadingView];
    
//        [_weekViewHostingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_eventLoadingView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_eventLoadingView)]];
//        [_weekViewHostingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_eventLoadingView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_eventLoadingView)]];
//        [_eventLoadingView setNeedsDisplay:YES];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Providing week events asynchronously");
//            self->_weekEventArrayController.filterPredicate = [NSPredicate predicateWithFormat:@"scheduledDate BETWEEN %@",@[request.startDate,request.endDate]];
//            [self->_weekEventArrayController rearrangeObjects];
//            self->_reloadingWeekData = NO;
//            NSLog(@"WeekEventManager: %lu events",[self->_weekEventArrayController.arrangedObjects count]);
//            [_asynchronousRequest completeWithEvents:self->_weekEventArrayController.arrangedObjects];
//            [_eventLoadingView removeFromSuperview];
//        });
//    }
}

#pragma mark - SCKEventManager Delegate

- (void)eventManager:(SCKEventManager *)eM didSelectEvent:(id<SCKEvent>)e {
//    NSString *who = (eM == _weekEventManager)?@"WeekView":@"DayView";
//    NSLog(@"%@: Did select event with title '%@'",who,[e title]);
}

- (void)eventManagerDidClearSelection:(SCKEventManager *)eM {
//    NSString *who = (eM == _weekEventManager)?@"WeekView":@"DayView";
//    NSLog(@"%@: Did clear selection",who);
}

- (void)eventManager:(SCKEventManager *)eM didDoubleClickEvent:(id<SCKEvent>)e {
    NSAlert *alert = [NSAlert new];
    alert.messageText = @"Double click";
    alert.informativeText = [NSString stringWithFormat:@"Clicked on event '%@'",[e title]];
    [alert runModal];
}

- (void)eventManager:(SCKEventManager *)eM didDoubleClickBlankDate:(NSDate *)d {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    df.timeStyle = NSDateFormatterMediumStyle;
    NSAlert *alert = [NSAlert new];
    alert.messageText = @"Double click on empty date";
    alert.informativeText = [NSString stringWithFormat:@"Clicked on empty date: '%@'",[df stringFromDate:d]];
    [alert runModal];
}

- (BOOL)eventManager:(SCKEventManager *)eM shouldChangeLengthOfEvent:(id<SCKEvent>)e fromValue:(NSInteger)oV toValue:(NSInteger)fV {
    NSAlert *alert = [NSAlert new];
    alert.messageText = @"Duration change";
    alert.informativeText = [NSString stringWithFormat:@"You've modified the duration of event '%@'.\n\nPrevious duration: %ld min.\nNew duration: %ld min.\n\nAre you sure?",[e title],oV,fV];
    [alert addButtonWithTitle:@"Save changes"];
    [alert addButtonWithTitle:@"Discard"];
    return ([alert runModal] == NSAlertFirstButtonReturn);
}

- (BOOL)eventManager:(SCKEventManager *)eM shouldChangeDateOfEvent:(id<SCKEvent>)e fromValue:(NSDate *)oD toValue:(NSDate *)fD {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    df.timeStyle = NSDateFormatterMediumStyle;
    NSAlert *alert = [NSAlert new];
    alert.messageText = @"Date change";
    alert.informativeText = [NSString stringWithFormat:@"You've modified the date and time of event '%@'.\n\nPrevious date: %@.\nNew date: %@.\n\nAre you sure?",[e title],[df stringFromDate:oD],[df stringFromDate:fD]];
    [alert addButtonWithTitle:@"Save changes"];
    [alert addButtonWithTitle:@"Discard"];
    return ([alert runModal] == NSAlertFirstButtonReturn);
}

#pragma mark - IBAction Methods

-(void)previousDay:(id)sender{
    [self setCurrentDisplayedDate:[self.currentDisplayedDate dateYesterday]];
    [self setDateForEventManager];
    [calendarManager getCalendarPlanningForStartingDate:_dayEventManager.view.startDate andEndDate:_dayEventManager.view.endDate];
    [_dayEventManager reloadData];
}

-(void)nextDay:(id)sender{
    [self setCurrentDisplayedDate:[self.currentDisplayedDate dateTomorrow]];
    [self setDateForEventManager];
    [calendarManager getCalendarPlanningForStartingDate:_dayEventManager.view.startDate andEndDate:_dayEventManager.view.endDate];
    [_dayEventManager reloadData];
}

-(void)setDateForEventManager{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *dayBeginning = [cal dateBySettingHour:8 minute:0 second:0 ofDate:self.currentDisplayedDate options:0];
    NSDate *dayEnding = [cal dateBySettingHour:6 minute:0 second:0 ofDate:[self.currentDisplayedDate dateByAddingDays:1] options:0];
    _dayEventManager.view.startDate = dayBeginning;
    _dayEventManager.view.endDate = dayEnding;
}

-(void)deleteAll:(id)sender{
    ProgramProvider *programProvider = [[ProgramProvider alloc] init];
    CalendarProvider *calendarProvider = [[CalendarProvider alloc] init];
    CPLsProvider *cplsProvider = [[CPLsProvider alloc] init];
    [programProvider deleteAll];
    [calendarProvider deleteAll];
    [cplsProvider deleteAll];
}

-(void)addAll:(id)sender{
    ProgramService *programService = [[ProgramService alloc] init];
    CPLService *cplService = [[CPLService alloc] init];
    CalendarService *calendarService = [[CalendarService alloc] init];
    
    [programService fetchDataDoOnSuccess:^{
        [statusTextfield setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        [statusTextfield setStringValue:@"Failure"];
    }];
    [cplService fetchDataDoOnSuccess:^{
        [statusTextfield2 setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        [statusTextfield2 setStringValue:@"Failure"];
    }];
    
    [calendarService fetchDataDoOnSuccess:^{
        //        [statusTextfield2 setStringValue:@"Success"];
    } onFailure:^(int errorCode, NSDictionary *errorMessages) {
        NSLog(@"error %d : %@", errorCode, [errorMessages description]);
        //        [statusTextfield2 setStringValue:@"Failure"];
    }];
}

@end
