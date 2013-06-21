//
//  MSExamModel.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSExamModel.h"
#import "EventKit/EventKit.h"

@interface MSExamModel ()
@property (nonatomic,strong) NSMutableArray *exams;
@property (nonatomic, strong) EKEventStore *calendarStore;
@end

@implementation MSExamModel

@synthesize exams = _exams;
@synthesize calendarStore = _calendarStore;

- (NSMutableArray*) exams{
    if(!_exams){
        _exams = [[NSMutableArray alloc]init];
    }
    return _exams;
}

- (EKEventStore*) calendarStore{
    NSLog(@"Calendar store create");
    if(!_calendarStore){
        _calendarStore = [[EKEventStore alloc] init];
    }
    
    if([_calendarStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        NSLog(@"Running on ios6");
        [_calendarStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            NSLog(@"User permited access to calendar for events");
        }];
    }
    
    
    return _calendarStore;
}

/**
 Loads Exams from now until now + given months.
 */
-(NSMutableArray*) loadExamsFromCalendar:(int)months{
    NSDate *startDate = [NSDate date];
    
    int daysToAdd = months * 30;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *endDate = [gregorian dateByAddingComponents:components toDate:startDate options:0];
    
    NSLog(@"Dates start: %@ end: %@",startDate,endDate);
    
    NSPredicate *predicate = [self.calendarStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *events = [self.calendarStore eventsMatchingPredicate:predicate];
    
    for (EKEvent *recentEvent in events) {
        MSExam *exam = [[MSExam alloc]init];
        exam.name = recentEvent.title;
        exam.startDate = recentEvent.startDate;
        exam.endDate = recentEvent.endDate;
        exam.notes = recentEvent.notes;
        
        [self.exams addObject:exam];
    }
    return self.exams;
}

-(NSMutableArray*) loadNextExamsFromCalendar:(int)months fromStartDate:(NSDate*) startDate{
    
    int daysToAdd = months * 30;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *endDate = [gregorian dateByAddingComponents:components toDate:startDate options:0];
    
    NSLog(@"Dates start: %@ end: %@",startDate,endDate);
    
    NSPredicate *predicate = [self.calendarStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *events = [self.calendarStore eventsMatchingPredicate:predicate];
    
    for (EKEvent *recentEvent in events) {
        MSExam *exam = [[MSExam alloc]init];
        exam.name = recentEvent.title;
        exam.startDate = recentEvent.startDate;
        exam.endDate = recentEvent.endDate;
        exam.notes = recentEvent.notes;
        
        [self.exams addObject:exam];
    }
    return self.exams;
}

-(void)safeExam:(MSExam*)exam{
    EKEvent *examEvent = [EKEvent eventWithEventStore:self.calendarStore];
    examEvent.calendar  = [self.calendarStore defaultCalendarForNewEvents];
    examEvent.title     = exam.name;
    examEvent.location  = exam.location;
    examEvent.notes     = exam.notes;
    examEvent.startDate = exam.startDate;
    examEvent.endDate   = exam.endDate;
    examEvent.allDay    = YES; //only for testing
    
    NSError *safeEventError;
    [self.calendarStore saveEvent:examEvent span:EKSpanThisEvent error:&safeEventError];
    
    if(safeEventError){
        NSLog(@"Couldn't safe event!");
    }else{
        NSLog(@"New event saved!");
    }
}





@end

