////
////  CoreDataHelper.m
////  AirTicketClient
////
////  Created by Дмитрий Федоринов on 17.05.2018.
////  Copyright © 2018 Geekbrains. All rights reserved.
////
//
//#import "CoreDataHelper.h"
//
//@interface CoreDataHelper()
//@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
//
//
//@end
//
//@implementation CoreDataHelper
//
//+(instancetype)sharedinstance{
//    static CoreDataHelper *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[CoreDataHelper alloc] init];
//        [instance setup];
//    });
//    return instance;
//}
//
//-(void)setup{
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"air" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
//    
//    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
//    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
//    if(!store){
//        abort();
//    }
//    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
//}
//
//-(void)save{
//    NSError *error;
//    [_managedObjectContext save: &error];
//    if (error){
//        NSLog(@"%@", [error localizedDescription]);
//    }
//}
//-(FavoriteTicket*)favoriteFromTicket:(Ticket*)ticket{
//    
//}
//-(BOOL)isFavorite:(Ticket *)ticket{
//    return [self favoriteFromTicket:ticket]! = nil;
//}
//
//
//
//@end
