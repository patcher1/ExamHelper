//
//  MSExamDetailViewController.h
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSExam.h"
#import "MSExamModel.h"
@interface MSExamDetailViewController : UIViewController

- (void)setDetailItem: (MSExam*) exam;
- (void)setModel:(MSExamModel*)model;
@end
