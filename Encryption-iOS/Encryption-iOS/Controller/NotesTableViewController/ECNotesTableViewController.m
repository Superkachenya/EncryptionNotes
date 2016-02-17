//
//  ECNotesTableViewController.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNotesTableViewController.h"
#import "ECNote.h"
#import "ECNoteManager.h"

NSString *const kreuseIdentifier = @"noteCell";

@interface ECNotesTableViewController ()

@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) ECNoteManager *manager;

@end

@implementation ECNotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [ECNoteManager sharedInstance];
    self.notes = [self.manager loadNotesUsingKey:self.key];
    if (!self.notes) {
        self.notes = [NSMutableArray new];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kreuseIdentifier forIndexPath:indexPath];
    ECNote *currentNote = self.notes[indexPath.row];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/YYYY HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:currentNote.creationDate];
    cell.textLabel.text = dateString;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)selectEditingMode:(id)sender {
    if(self.editing) {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    } else {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addNote"]) {
        ECNoteViewController *detailsController = [segue destinationViewController];
        detailsController.delegate = self;
        detailsController.key = self.key;
    }
    if ([segue.identifier isEqualToString:@"noteDetails"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        ECNoteViewController *detailsController = [segue destinationViewController];
        detailsController.currentNote = self.notes[indexPath.row];
        detailsController.key = self.key;
    }
}

#pragma mark - ECNoteDetailsDelegate

- (void)detailsViewController:(ECNoteViewController *)controller saveNote:(ECNote *)note {
    [self.notes addObject:note];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.notes count] - 1) inSection:0];
    [self. tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
