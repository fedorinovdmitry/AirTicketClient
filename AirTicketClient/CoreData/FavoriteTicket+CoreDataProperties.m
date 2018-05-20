//
//  FavoriteTicket+CoreDataProperties.m
//  
//
//  Created by Дмитрий Федоринов on 18.05.2018.
//
//

#import "FavoriteTicket+CoreDataProperties.h"

@implementation FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
}

@dynamic created;
@dynamic to;
@dynamic from;
@dynamic airline;
@dynamic returnDate;
@dynamic expires;
@dynamic departure;
@dynamic flightNumber;
@dynamic price;
@dynamic toFullName;
@dynamic fromFullName;

@end
