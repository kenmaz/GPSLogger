//
//  LogViewController.m
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import "LogViewController.h"
#import "Location.h"
#import "MapViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController {
    NSArray* _locations;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Location* loc = [_locations objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", loc.lat, loc.lng];
    cell.detailTextLabel.text = [loc.createdAt description];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Location* loc = [_locations objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"map" sender:loc];
}

- (IBAction)touchAddButton:(id)sender {
    Location* loc = [Location MR_createEntity];
    loc.lat = [NSNumber numberWithDouble:34.1234];
    loc.lng = [NSNumber numberWithDouble:128.1234];
    loc.createdAt = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL result, NSError* error){
        [self reloadLocations];
    }];
}

- (IBAction)touchRefreshButton:(id)sender {
    [self reloadLocations];
}

- (void)reloadLocations {
    _locations = [Location MR_findAllSortedBy:@"createdAt" ascending:NO];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"map"]) {
        Location* loc = sender;
        MapViewController* con = segue.destinationViewController;
        con.location = loc;
    }
}

@end
