//
//  ECNotesTableViewController.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECNoteViewController.h"

@interface ECNotesTableViewController : UITableViewController <ECNoteDetailsDelegate>

@property (strong, nonatomic) NSString *key;

@end
