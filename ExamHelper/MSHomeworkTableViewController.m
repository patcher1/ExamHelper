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

@interface MSHomeworkTableViewController ()
@property (nonatomic, strong) NSMutableArray *homework;
@property (nonatomic, strong) MSHomework *exampleHomework;
@end

@implementation MSHomeworkTableViewController
@synthesize exampleHomework;
@synthesize homework = _homework;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*****************************************************/
    // TODO Remove! This is for testing purposes only!
    if(!_homework) {
        _homework = [[NSMutableArray alloc] init];
    }
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
    /*****************************************************/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return [_homework count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Table View Creation");
    MSHomework *currentHomeworkElement = [self.homework objectAtIndex:indexPath.row];
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
    [[segue destinationViewController] setDetailItem:[self.homework objectAtIndex:indexPath.row]];
}

- (void) setHomework:(NSMutableArray *)homework {
    _homework = homework;
}

@end
