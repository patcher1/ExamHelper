//
//  MSExamModel.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSExamModel.h"
#import "MSExam.h"
#import "EventKit/EventKit.h"

@interface MSExamModel ()
@property (nonatomic,strong) NSMutableArray *exams;
@property (nonatomic, strong) EKEventStore *calendarStore;
@end

@implementation MSExamModel

@synthesize exams = _exams;
@synthesize calendarStore = _calendarStore;
//hallo
- (NSMutableArray*) exams{
    if(!_exams){
        _exams = [self loadExamsFromCalendar:12];
    }
    return _exams;
}

- (EKEventStore*) store{
    if(!_calendarStore){
        _calendarStore = [[EKEventStore alloc] init];
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



@end

