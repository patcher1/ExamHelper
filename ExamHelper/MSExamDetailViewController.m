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
@property (weak, nonatomic) NSDateFormatter* dateFormatter;
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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.examTitleTextField.text = self.exam.name;
    self.startDateTextfield.text = [self.dateFormatter stringFromDate:self.exam.startDate];
    self.endDateTextField.text = [self.dateFormatter stringFromDate:self.exam.endDate];
    self.locationTextField.text = self.exam.location;
    self.notesTextView.text = self.exam.notes;
    [self disableEditingForEditableUIElements];
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
         NSLog(@"Changing to edit mode");
        [self enableEditingForEditableUIElements];
    }
    else {
        NSLog(@"Saving changes");
        [self disableEditingForEditableUIElements];
        [self.exam setName: self.examTitleTextField.text];
        [self.exam setStartDate: [self.dateFormatter dateFromString:self.startDateTextfield.text]];
        [self.exam setEndDate: [self.dateFormatter dateFromString:self.endDateTextField.text]];
        [self.exam setLocation: self.locationTextField.text];
        [self.exam setNotes: self.notesTextView.text];
        
        // TODO: Save this!
    }
}

- (void)disableEditingForEditableUIElements {
    self.examTitleTextField.userInteractionEnabled = NO;
    self.startDateTextfield.userInteractionEnabled = NO;
    self.endDateTextField.userInteractionEnabled = NO;
    self.locationTextField.userInteractionEnabled = NO;
    self.notesTextView.userInteractionEnabled = NO;
}

- (void)enableEditingForEditableUIElements {
    self.examTitleTextField.userInteractionEnabled = YES;
    self.startDateTextfield.userInteractionEnabled = YES;
    self.endDateTextField.userInteractionEnabled = YES;
    self.locationTextField.userInteractionEnabled = YES;
    self.notesTextView.userInteractionEnabled = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setDetailItem: (MSExam*) exam {
    self.exam = exam;
}

@end
