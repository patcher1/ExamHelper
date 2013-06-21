//
//  MSExam.m
//  ExamHelper
//  
//  Class for the ExamController to work with. Is basically a wrapper for an EKEvent to keep the model independent from the EventKit framework.
//  
//  Created by Yannick Seitz on 20.06.13.
//  Copyright (c) 2013 Yannick Seitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSExam : NSObject
extern const NSString *EXAM_PREFIX;
- (NSString*) name;
- (NSString*) location;
- (NSString*) notes;
- (NSString*) startDate;
- (NSString*) endDate;

- (void) setName:(NSString*)name;
- (void) setNotes:(NSString*)notes;
- (void) setLocation:(NSString*)location;
- (void) setStartDate:(NSString*)startDate;
- (void) setEndDate:(NSString*)endDate;

@end
