//
//  MSExam.m
//  ExamHelper
//  
//  Class for the ExamController to work with. Is basically a wrapper for an EKEvent to keep the model independent from the EventKit framework.
//  
//  Created by Yannick Seitz on 20.06.13.
//  Copyright (c) 2013 Yannick Seitz. All rights reserved.
//

#import "MSExam.h"

const NSString *EXAM_PREFIX = @"[EXAM]";

@interface MSExam()
@property (nonatomic,strong) NSString *name;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *notes;

@end

@implementation MSExam

@synthesize name = _name;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize location = _location;
@synthesize notes = _notes;

- (NSString*) name{
    if(!_name){
        _name = [NSString string];
    }
    return _name;
}

- (NSString*) location{
    if(!_location){
        _location = [NSString string];
    }
    return _location;
}

- (NSString*) startDate{
    if(!_startDate){
        _startDate = [NSDate date];
    }
    return _startDate;
}

- (NSString*) endDate{
    if(!_endDate){
        _endDate = [NSDate date];
    }
    return _endDate;

}

@end
