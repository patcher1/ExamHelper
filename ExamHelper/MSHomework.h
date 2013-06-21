//
//  MSHomework.h
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSHomework : NSObject
extern const NSString *HOMEWORK_PREFIX;
- (NSString*) name;
- (NSString*) note;
- (BOOL*) done;

- (void) setName: (NSString*) name;
- (void) setNote: (NSString*) note;
- (void) setDone: (BOOL*) done;

@end
