//
//  MSExamDetailViewController.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSExamDetailViewController.h"

@interface MSExamDetailViewController ()
@property (nonatomic, strong) MSExam *exam;
@property (weak, nonatomic) IBOutlet UILabel *examTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@end

@implementation MSExamDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    _examTitleLabel.text = _exam.name;
    _startDateLabel.text = [dateFormatter stringFromDate:_exam.startDate];
    _endDateLabel.text = [dateFormatter stringFromDate:_exam.endDate];
    _locationLabel.text = _exam.location;
    _notesTextView.text = _exam.notes;
    _notesTextView.userInteractionEnabled = NO;
}

- (void)viewDidUnload
{
    [self setExamTitleLabel:nil];
    [self setStartDateLabel:nil];
    [self setEndDateLabel:nil];
    [self setLocationLabel:nil];
    [self setNotesTextView:nil];
    [self setNotesTextView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setDetailItem: (MSExam*) exam {
    _exam = exam;
}

@end
