//
//  DetailViewController.m
//  FurnitureTracker
//
//  Created by Auston Salvana on 7/24/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "DetailViewController.h"
#import "Furniture.h"

@interface DetailViewController ()

@property (nonatomic) UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property RLMRealm *realm;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    self.realm = [RLMRealm defaultRealm];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.roomDetailItem.allFurniture.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Furniture *furnitureObject = self.roomDetailItem.allFurniture[indexPath.row];
    cell.textLabel.text = furnitureObject.name;
    return cell;
}

#pragma mark - IBAction methods

- (IBAction)addFurniture:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Furniture" message:@"Name the furniture you want to add to your room!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Create object
        Furniture *furniture = [[Furniture alloc] init];
        furniture.name = self.textField.text;
        
        // Add to Realm with transaction
        [self.realm beginWriteTransaction];
        [self.roomDetailItem.allFurniture addObject:furniture];
        [self.realm commitWriteTransaction];
        
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

@end
