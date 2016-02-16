//
//  ECNoteManager.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNoteManager.h"
#import "ECNote.h"
#import "ECEncryptor.h"

@implementation ECNoteManager

+ (instancetype)sharedInstance {
    static ECNoteManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ECNoteManager new];
    });
    return sharedInstance;
}

- (NSString *)fullPathToFile {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                         inDomains:NSUserDomainMask] lastObject];
    NSString *path = [url.path stringByAppendingPathComponent:@"notes.json"];
    return path;
}

- (void)saveNotes:(NSMutableArray *)notes {
    NSString *path = [self fullPathToFile];
    NSError *error = nil;
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/YYYY HH:mm:ss";
    for (ECNote *note in notes) {
        NSString *dateString = [formatter stringFromDate:note.creationDate];
        NSString *encryptString = [self encryptMe:note.noteText];
        NSDictionary *tempDict = @{@"creationDate" : dateString,
                                   @"noteText" : encryptString};
        [dictionary setObject:tempDict forKey:dateString];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    [jsonData writeToFile:path atomically:YES];
}

- (NSMutableArray *)loadNotes {
    NSString *filePath = [self fullPathToFile];
    NSMutableArray *array = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        NSURL *localFileURL = [NSURL fileURLWithPath:filePath];
        NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:localFileURL];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
        array = [NSMutableArray new];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM/dd/YYYY HH:mm:ss"];
        for (id note in jsonObject) {
            NSDictionary *currentNoteDict = [jsonObject objectForKey:(NSString *)note];
            NSDate *date = [dateFormatter dateFromString: [currentNoteDict objectForKey:@"creationDate"]];
            ECNote *loadedNote = [ECNote new];
            loadedNote.creationDate = date;
            loadedNote.noteText = [currentNoteDict objectForKey:@"noteText"];
            [array addObject:loadedNote];
        }
    }
    return array;
}

- (NSString *)encryptMe:(NSString *)string {
    NSString *key = @"CoolMan";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    char *dataPtr = (char *) [data bytes];
    char *keyData = (char *) [[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex = 0;
    for (int x = 0; x < [data length]; x++)
    {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        if (++keyIndex == [key length])
            keyIndex = 0, keyPtr = keyData;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
