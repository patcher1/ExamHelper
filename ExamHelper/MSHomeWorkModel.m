//
//  MSHomeWorkModel.m
//  ExamHelper
//
//  Created by Benutzer on 21.06.13.
//
//

#import "MSHomeWorkModel.h"
#import "EventKit/EventKit.h"

@interface MSHomeWorkModel()
@property (nonatomic,strong) NSMutableArray *homeworks;
@property (nonatomic, strong) EKEventStore *calendarStore;
@end

@implementation MSHomeWorkModel
@synthesize homeworks = _homeworks;
@synthesize calendarStore = _calendarStore;

- (NSMutableArray*) homeworks{
    if(!_homeworks){
        _homeworks = [[NSMutableArray alloc]init];
    }
    return _homeworks;
}

- (EKEventStore*) calendarStore{
    NSLog(@"Calendar store create");
    if(!_calendarStore){
        _calendarStore = [[EKEventStore alloc] init];
    }
    
    if([_calendarStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        NSLog(@"Running on ios6");
        [_calendarStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            NSLog(@"User permited access to calendar for reminders");
        }];
    }
    
    
    return _calendarStore;
}

/**
 Loads Homeworks from now until now + given months.
 */
-(NSMutableArray*) loadHomeworksFromCalendar:(int)months{
    NSDate *startDate = [NSDate date];
    
    int daysToAdd = months * 30;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *endDate = [gregorian dateByAddingComponents:components toDate:startDate options:0];
    
    NSLog(@"Dates start: %@ end: %@",startDate,endDate);
    
    NSPredicate *predicate = [self.calendarStore predicateForIncompleteRemindersWithDueDateStarting:startDate ending:endDate calendars:nil];
    
    [self.calendarStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        for (EKReminder *reminder in reminders) {
            MSHomework *homework = [[MSHomework alloc]init];
            homework.name = reminder.title;
            homework.note = reminder.notes;
            [self.homeworks addObject:homework];
        }
    }];

    return self.homeworks;
}



-(void)saveHomework:(MSHomework*)homework{
    EKReminder *homeworkReminder = [EKReminder reminderWithEventStore:self.calendarStore];
    homeworkReminder.calendar  = [self.calendarStore defaultCalendarForNewReminders];
    homeworkReminder.title = homework.name;
    homeworkReminder.notes = homework.note;
        
    NSError *safeReminderError;
    [self.calendarStore saveReminder:homeworkReminder commit:YES error:&safeReminderError];
    
    if(safeReminderError){
        NSLog(@"Couldn't safe reminder!");
    }else{
        NSLog(@"New reminder saved!");
    }
}
- (void) deleteHomework:(MSHomework*) homework{
    
}

@end
