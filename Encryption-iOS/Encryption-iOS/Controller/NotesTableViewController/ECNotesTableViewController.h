//
//  ECNotesTableViewController.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECNoteViewController.h"

@interface ECNotesTableViewController : UITableViewController

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSMutableArray *notes;

@end
