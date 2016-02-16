//
//  ECNoteManager.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNoteManager.h"
#import "ECNote.h"

@implementation ECNoteManager

+ (instancetype)sharedInstance {
    static ECNoteManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ECNoteManager new];
    });
    return sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (void)saveNotes:(NSMutableArray *)notes {
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"notes.json"];
    NSError *error = nil;
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm:ss";
    for (ECNote *note in notes) {
        ECNote *tempNote = note;
        NSString *keyString = [formatter stringFromDate:tempNote.creationDate];
        [dictionary setObject:tempNote.noteText forKey:keyString];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    [jsonData writeToFile:path atomically:YES];
    NSLog(@"%@",path);
}

- (ECNote *)loadNote {
    NSString *filePath = [[self applicationDocumentsDirectory].path
                          stringByAppendingPathComponent:@"notes.json"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {        
    }
    return nil;
}


@end
