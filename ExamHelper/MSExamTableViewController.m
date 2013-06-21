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
@property (nonatomic, strong) MSExamModel *model;
@property (weak, nonatomic) NSDateFormatter* dateFormatter;
@end

@implementation MSExamTableViewController
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
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
<<<<<<< HEAD
=======
    [self.dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    if(!_exams) {
        _exams = [[NSMutableArray alloc] init];
    }
>>>>>>> c2cf03ca4c6533ea7618cdad0cc420686c931f03
}

- (void)insertNewObject:(id)sender
{
    MSExam *newExam = [[MSExam alloc] init];
    
    [newExam setName:@"Exam"];
    [newExam setStartDate:[[NSDate alloc] init]];
    [newExam setEndDate:[[NSDate alloc] init]];
    [newExam setLocation:@"Zürich"];
    [newExam setNotes:@"Template, you can edit this now"];
    
    [self.exams addObject:newExam];
    NSLog(@"New exam added");
    
    NSLog(@"Date info: %@ %@", [self.dateFormatter stringFromDate:newExam.startDate], [self.dateFormatter stringFromDate:newExam.endDate]);
    
    // TODO Save the new item
    [self.model safeExam:newExam];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.exams removeObjectAtIndex:indexPath.row];
    }
    
    // TODO Delete the new item
    
    [self.tableView reloadData];
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
    return [self.exams count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    
    if(!_exams){
         _exams = [self.model loadExamsFromCalendar:12];
        NSLog(@"Exams loaded");
    }
    return _exams;
}

-(MSExamModel*)model{
    if(!_model){
        _model = [[MSExamModel alloc]init];
        NSLog(@"MSExamModel created");
    }
    return _model;
}

- (void) setExams:(NSMutableArray *)exams {
    _exams = exams;
}

@end
