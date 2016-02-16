//
//  ECNoteViewController.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNoteViewController.h"
#import "ECNote.h"

@interface ECNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteText;

@end

@implementation ECNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteText.text = self.currentNote.noteText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)SaveButtonPressed:(id)sender {
    self.currentNote.noteText = self.noteText.text;
    if ([self.delegate respondsToSelector:@selector(detailsViewController:saveNote:)]) {
        [self.delegate detailsViewController:self saveNote:self.currentNote];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
