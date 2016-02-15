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

- (void)saveNote:(ECNote *)note {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *notePath = [NSString stringWithFormat:@"%@.txt", [formatter stringFromDate:note.creationDate]];
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:notePath];
    [NSKeyedArchiver archiveRootObject:note toFile:path];
    NSLog(@"%@",path);
}

- (ECNote *)loadNote {
    ECNote *loadedNote = nil;
    NSString *filePath = [[self applicationDocumentsDirectory].path
                          stringByAppendingPathComponent:@".txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        loadedNote = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return loadedNote;
}


@end
