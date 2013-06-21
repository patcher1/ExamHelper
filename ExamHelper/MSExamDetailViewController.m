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

@property (weak, nonatomic) IBOutlet UITextField *examTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *startDateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
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
    _examTitleTextField.text = _exam.name;
    _startDateTextfield.text = [dateFormatter stringFromDate:_exam.startDate];
    _endDateTextField.text = [dateFormatter stringFromDate:_exam.endDate];
    _locationTextField.text = _exam.location;
    _notesTextView.text = _exam.notes;
    _notesTextView.userInteractionEnabled = NO;
}

- (void)viewDidUnload
{
    [self setNotesTextView:nil];
    [self setNotesTextView:nil];
    [self setExamTitleTextField:nil];
    [self setStartDateTextfield:nil];
    [self setEndDateTextField:nil];
    [self setLocationTextField:nil];
    [super viewDidUnload];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    if (flag == YES){
        self.examTitleTextField.userInteractionEnabled = YES;
        self.startDateTextfield.userInteractionEnabled = YES;
        self.endDateTextField.userInteractionEnabled = YES;
        self.locationTextField.userInteractionEnabled = YES;
        self.notesTextView.userInteractionEnabled = YES;
        NSLog(@"Changing to edit mode");
    }
    else {
        NSLog(@"Saving changes");
        self.examTitleTextField.userInteractionEnabled = NO;
        self.startDateTextfield.userInteractionEnabled = NO;
        self.endDateTextField.userInteractionEnabled = NO;
        self.locationTextField.userInteractionEnabled = NO;
        self.notesTextView.userInteractionEnabled = NO;
        
        [self.exam setName: self.examTitleTextField.text];
        [self.exam setName: self.startDateTextfield.text];
        [self.exam setName: self.endDateTextField.text];
        [self.exam setName: self.locationTextField.text];
        [self.exam setName: self.notesTextView.text];
        
        // TODO: Save this!
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setDetailItem: (MSExam*) exam {
    _exam = exam;
}

@end
