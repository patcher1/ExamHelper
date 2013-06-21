//
//  MSHomeWorkModel.h
//  ExamHelper
//
//  Created by Benutzer on 21.06.13.
//
//

#import <Foundation/Foundation.h>
#import "MSHomework.h"

@interface MSHomeWorkModel : NSObject
-(NSMutableArray*) homeworks;
-(NSMutableArray*) loadHomeworksFromCalendar;
- (void) saveHomework:(MSHomework*) homework;
- (void) deleteHomework:(MSHomework*) homework;
@end
