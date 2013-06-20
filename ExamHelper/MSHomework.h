//
//  MSHomework.h
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSHomework : NSObject

- (NSString*) name;
- (void) setName: (NSString*) name;
- (NSString*) note;
- (void) setNote: (NSString*) note;
- (BOOL*) done;
- (void) setDone: (BOOL*) done;

@end
