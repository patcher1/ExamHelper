//
//  MSHomeworkTableViewController.m
//  ExamHelper
//
//  Created by Benutzer on 20.06.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MSHomeworkTableViewController.h"
#import "MSHomeworkDetailViewController.h"
#import "MSHomework.h"
#import "MSHomeWorkModel.h"

@interface MSHomeworkTableViewController ()
<<<<<<< HEAD
@property (nonatomic, strong) NSMutableArray *homeworks;
@property (nonatomic,strong) MSHomeWorkModel *model;
@property (nonatomic, strong) MSHomework *exampleHomework;
@end

@implementation MSHomeworkTableViewController
@synthesize exampleHomework;
@synthesize homeworks = _homeworks;
@synthesize model = _model;

- (MSHomeWorkModel*)model{
    if(!_model){
        _model = [[MSHomeWorkModel alloc]init];
    }
    return _model;
}
=======
@property (nonatomic, strong) NSMutableArray *homework;
@end

@implementation MSHomeworkTableViewController
@synthesize homework = _homework;
>>>>>>> 8a9f8e51c81362eb349be53e1811954b028082ba

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
    
    if(!_homeworks) {
        _homeworks = [[NSMutableArray alloc] init];
    }
<<<<<<< HEAD
    /*****************************************************
    // TODO Remove! This is for testing purposes only!
    exampleHomework = [[MSHomework alloc] init];
    [exampleHomework setName: @"Complete Presentation" ];
    [exampleHomework setNote: @"Don't forget the handout" ];
    [exampleHomework setDone: NO ];
    [_homework addObject:exampleHomework];
    exampleHomework = [[MSHomework alloc] init];
    [exampleHomework setName: @"Complete App" ];
    [exampleHomework setNote: @"Don't forget to refactor" ];
    [exampleHomework setDone: YES ];
    [_homework addObject:exampleHomework];
    *****************************************************/
=======
>>>>>>> 8a9f8e51c81362eb349be53e1811954b028082ba
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender
{
    MSHomework *newHomework = [[MSHomework alloc] init];
    
    [newHomework setName:@"Homework"];
    [newHomework setNote:@"Template, you can edit this now"];
    [newHomework setDone: NO];
    
    [self.homeworks addObject:newHomework];
    
    // TODO Save the new item
    [self.model saveHomework:newHomework];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.homeworks removeObjectAtIndex:indexPath.row];
    }
    
    // TODO Delete the new item
    
    [self.tableView reloadData];
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
    return [self.homeworks count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSHomework *currentHomeworkElement = [self.homeworks objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"HomeworkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(![currentHomeworkElement done]) {
        cell.imageView.image = [UIImage imageNamed: @"historical-26.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed: @"checkmark-26.png"];
    }
    
    cell.textLabel.text = [currentHomeworkElement name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [[segue destinationViewController] setDetailItem:[self.homeworks objectAtIndex:indexPath.row]];
}

- (void) setHomework:(NSMutableArray *)homework {
    _homeworks = homework;
}

-(NSMutableArray*)homeworks{
    if(!_homeworks){
        _homeworks = [self.model loadHomeworksFromCalendar:12];
    }
    return _homeworks;
}

@end
