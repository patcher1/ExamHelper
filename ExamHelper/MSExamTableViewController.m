//
//  MSExamTableViewController.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSExamTableViewController.h"
#import "MSExamDetailViewController.h"
#import "MSExam.h"
#import "MSExamModel.h"

@interface MSExamTableViewController ()
@property (nonatomic, strong) NSMutableArray *exams;
@property (nonatomic, strong) MSExam *exampleExam;
@property (nonatomic, strong) MSExamModel *model;
@end

@implementation MSExamTableViewController
@synthesize exampleExam;
@synthesize exams = _exams;
@synthesize model = _model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*****************************************************/
    /* TODO Remove! This is for testing purposes only!
    if(!_exams) {
        _exams = [[NSMutableArray alloc] init];
    }
    exampleExam = [[MSExam alloc] init];
    [exampleExam setStartDate: [[NSDate alloc] init]];
    [exampleExam setEndDate: [[NSDate alloc] init]];
    [exampleExam setName: @"German Exam" ];
    [exampleExam setNotes: @"Study hard! It's difficult" ];
    [exampleExam setLocation: @"Zürich" ];
    [_exams addObject:exampleExam];
    ****************************************************/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_exams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExamCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[self.exams objectAtIndex:indexPath.row] name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setDetailItem:[self.exams objectAtIndex:indexPath.row]];
}

-(NSMutableArray*)exams{
    if(_exams){
        _exams = [self.model loadExamsFromCalendar:12];
        NSLog(@"Exams loaded");
    }
    return _exams;
}

-(MSExamModel*)model{
    if(_model){
        _model = [[MSExamModel alloc]init];
        NSLog(@"MSExamModel created");
    }
    return _model;
}

- (void) setExams:(NSMutableArray *)exams {
    _exams = exams;
}

@end
