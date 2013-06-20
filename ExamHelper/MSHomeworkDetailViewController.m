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
@property (weak, nonatomic) IBOutlet UILabel *homeworkTitleLabel;
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
    _homeworkTitleLabel.text = _homework.name;
    _notesTextView.text = _homework.note;
    _notesTextView.userInteractionEnabled = NO;
    _isHomeworkDoneSwitch.on = _homework.done;
}

- (void)viewDidUnload
{
    [self setHomeworkTitleLabel:nil];
    [self setNotesTextView:nil];
    [self setIsHomeworkDoneSwitch:nil];
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

- (void)setDetailItem: (MSHomework*) homework {
    _homework = homework;
}

@end
