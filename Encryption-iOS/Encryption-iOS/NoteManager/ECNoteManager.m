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

- (void)saveNote:(ECNote *)note usingKey:(NSString *)key {
    NSString *path = [self fullPathToFile];
    NSError *error = nil;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd/yyyy HH:mm:ss";
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *dateString = [formatter stringFromDate:note.creationDate];
    NSString *encryptString = [ECEncryptor encryptMe:note.noteText withKey:key];
    NSDictionary *inDict = @{@"creationDate" : dateString,
                                 @"noteText" : encryptString};
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:path];
        NSMutableDictionary *jsonDict = [[NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error]mutableCopy];
        [jsonDict setObject:inDict forKey:dateString];
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        NSLog(@"%@",jsonData);
        NSLog(@"%@",jsonDict);
        [jsonData writeToFile:path atomically:YES];
    } else {
        NSDictionary *dict = @{dateString : inDict};
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        [jsonData writeToFile:path atomically:YES];
    }
}

- (NSMutableArray *)loadNotesUsingKey:(NSString *)key {
    NSString *path = [self fullPathToFile];
    NSMutableArray *array = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:path];
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
        array = [NSMutableArray new];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        formatter.locale = [NSLocale currentLocale];
        formatter.timeZone = [NSTimeZone systemTimeZone];
        for (id note in jsonData) {
            NSDictionary *currentNoteDict = [jsonData objectForKey:(NSString *)note];
            NSLog(@"%@",currentNoteDict);
            NSDate *date = [formatter dateFromString: [currentNoteDict objectForKey:@"creationDate"]];
            ECNote *loadedNote = [ECNote new];
            loadedNote.creationDate = date;
            NSString *decryptedString = [ECEncryptor encryptMe:[currentNoteDict objectForKey:@"noteText"] withKey:key];
            loadedNote.noteText = decryptedString;
            [array addObject:loadedNote];
        }
    }
    return array;
}

- (void)removeNoteForKey:(NSString *)key {
    NSString *path = [self fullPathToFile];
    NSError *error = nil;
    NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *jsonDict = [[NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error]mutableCopy];
    [jsonDict removeObjectForKey:key];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    [jsonData writeToFile:path atomically:YES];
}

@end
