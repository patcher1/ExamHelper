//
//  MSExamModel.h
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSExam.h"

@interface MSExamModel : NSObject
-(NSMutableArray*) exams;
-(NSMutableArray*) loadExamsFromCalendar:(int)months;
-(NSMutableArray*) loadNextExamsFromCalendar:(int)months fromStartDate:(NSDate*) startDate;
- (void) safeExam:(MSExam*) exam;
- (void) deleteExam:(MSExam*) exam;
@end

