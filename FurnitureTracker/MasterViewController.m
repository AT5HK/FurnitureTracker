//
//  MasterViewController.m
//  FurnitureTracker
//
//  Created by Auston Salvana on 7/24/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Room.h"
#import <Realm/Realm.h>

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (nonatomic) UITextField *textField;
@property RLMResults *allRooms;
@property RLMRealm *realm;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    // Get the default Realm
    self.realm = [RLMRealm defaultRealm];
    self.allRooms = [Room allObjects];
}

- (void)insertNewObject:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Room" message:@"Name the room you want to add" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //persist data
        // Create object
        Room *room = [[Room alloc] init];
        room.name = self.textField.text;
        
        // You only need to do this once (per thread)
        
        // Add to Realm with transaction
        [self.realm transactionWithBlock:^{
            [self.realm addObject:room];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        self.textField = textField;
    }];
    [alert addAction:save];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailViewController"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Room *RLMobject = self.allRooms[indexPath.row];
        [[segue destinationViewController] setRoomDetailItem:RLMobject];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allRooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Room *roomObject = self.allRooms[indexPath.row];
    cell.textLabel.text = roomObject.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - helper methods

@end
