//
//  CoreDataHelper.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 17.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;


@end

@implementation CoreDataHelper

+(instancetype)sharedinstance{
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

-(void)setup{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FavoriteTicket" withExtension:@"momd"];
    NSLog(@"%@", modelURL);
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
 
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if(!store){
        abort();
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

-(void)save{
    NSError *error;
    [_managedObjectContext save: &error];
    if (error){
        NSLog(@"%@", [error localizedDescription]);
    }
}
-(FavoriteTicket*)favoriteFromTicket:(Ticket*)ticket{
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld AND fromFullName == %@ AND toFullName == %@", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue, ticket.fromFullName, ticket.toFullName];
    FavoriteTicket *favoriteTicket = [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
    return favoriteTicket;
}
-(BOOL)isFavorite:(Ticket *)ticket{
    BOOL is = [self favoriteFromTicket:ticket] != nil;
    return is;
}
-(void)addToFavorite:(Ticket *)ticket{
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:_managedObjectContext];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.fromFullName = ticket.fromFullName;
    favorite.toFullName = ticket.toFullName;
    favorite.created = [NSDate date];
    [self save];
}
-(void)removeFromFavorite:(Ticket *)ticket{
    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
    if(favorite){
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}
-(NSArray *)favorites{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    NSArray *favorites = [_managedObjectContext executeFetchRequest:request error:nil];
    return favorites;
}



@end
