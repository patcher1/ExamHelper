//
//  MSHomeworkDetailViewController.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSHomeworkDetailViewController.h"
#import "MSHomework.h"

@interface MSHomeworkDetailViewController ()
@property (nonatomic, strong) MSHomework *homework;
@property (weak, nonatomic) IBOutlet UITextField *homeworkTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UISwitch *isHomeworkDoneSwitch;
@end

@implementation MSHomeworkDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.homeworkTitleTextField.text = self.homework.name;
    self.notesTextView.text = self.homework.note;
    self.isHomeworkDoneSwitch.on = self.homework.done;
    [self disableEditingForEditableUIElements];
}

- (void)viewDidUnload
{
    [self setNotesTextView:nil];
    [self setIsHomeworkDoneSwitch:nil];
    [self setHomeworkTitleTextField:nil];
    [super viewDidUnload];
}

- (IBAction)isHomeworkDoneToggle:(UISwitch *)sender {
    [self.homework setDone: sender.on];
    // TODO: Save this!
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        [self.homework setName: self.homeworkTitleTextField.text];
        [self.homework setNote: self.notesTextView.text];
        [self.homework setDone: self.isHomeworkDoneSwitch.on];
        // TODO: Save this!
    }
}

- (void)disableEditingForEditableUIElements {
    self.homeworkTitleTextField.userInteractionEnabled = NO;
    self.notesTextView.userInteractionEnabled = NO;
}

- (void)enableEditingForEditableUIElements {
    self.homeworkTitleTextField.userInteractionEnabled = YES;
    self.notesTextView.userInteractionEnabled = YES;
}

- (void)setDetailItem: (MSHomework*) homework {
    self.homework = homework;
}

@end
