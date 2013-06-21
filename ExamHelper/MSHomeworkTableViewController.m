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
@property (nonatomic, strong) NSMutableArray *homeworks;
@property (nonatomic,strong) MSHomeWorkModel *model;
@end

@implementation MSHomeworkTableViewController
@synthesize homeworks = _homeworks;
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
        NSLog(@"Homeworks loaded");
    }
    return _homeworks;
}
- (MSHomeWorkModel*)model{
    if(!_model){
        _model = [[MSHomeWorkModel alloc]init];
        NSLog(@"Model created");
    }
    return _model;
}

@end
