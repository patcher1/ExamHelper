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
    
    _homeworkTitleTextField.borderStyle = UITextBorderStyleNone;
    _homeworkTitleTextField.userInteractionEnabled = NO;
    _homeworkTitleTextField.text = _homework.name;
    _notesTextView.text = _homework.note;
    _notesTextView.userInteractionEnabled = NO;
    _isHomeworkDoneSwitch.on = _homework.done;
}

- (void)viewDidUnload
{
    [self setNotesTextView:nil];
    [self setIsHomeworkDoneSwitch:nil];
    [self setHomeworkTitleTextField:nil];
    [super viewDidUnload];
}

- (IBAction)isHomeworkDoneToggle:(UISwitch *)sender {
    [_homework setDone: sender.on];
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
        _homeworkTitleTextField.userInteractionEnabled = YES;
        _notesTextView.userInteractionEnabled = YES;
        NSLog(@"Changing to edit mode");
    }
    else {
        NSLog(@"Saving changes");
        _homeworkTitleTextField.userInteractionEnabled = NO;
        _notesTextView.userInteractionEnabled = NO;
        
        [_homework setName: _homeworkTitleTextField.text];
        [_homework setNote: _notesTextView.text];
        [_homework setDone: _isHomeworkDoneSwitch.on];
        
        // TODO: Save this!
    }
}

- (void)setDetailItem: (MSHomework*) homework {
    _homework = homework;
}

@end
