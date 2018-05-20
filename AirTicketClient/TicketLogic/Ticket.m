//
//  Ticket.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket

-(instancetype)initWithDictionary:(NSDictionary  *)dictionary{
    self = [super  init];
    if (self){
        _airline = [dictionary valueForKey:@"airline"];
        _expires = dateFromString ([dictionary valueForKey: @"expires_at"]);
        _departure = dateFromString ([dictionary valueForKey: @"departure_at"]);
        _flightNumber = [dictionary valueForKey: @"flight_number"];
        _price = [dictionary valueForKey: @"price"];
        _returnDate = dateFromString ([dictionary valueForKey: @"return_at"]);
    }
    return  self;
}

-(instancetype)initWithFavorite:(FavoriteTicket *)favorite{
    self = [super init];
    if(self){
        _price = [NSNumber numberWithLong:favorite.price];
        _airline = favorite.airline;
        _departure = favorite.departure;
        _expires = favorite.expires;
        _flightNumber = [NSNumber numberWithInt:favorite.flightNumber];
        _returnDate = favorite.returnDate;
        _from = favorite.from;
        _to = favorite.to;
        _fromFullName = favorite.fromFullName;
        _toFullName = favorite.toFullName;
    }
    return self;
}

NSDate *dateFromString(NSString *dateString) {
    if (!dateString) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *correctSrtingDate = [dateString stringByReplacingOccurrencesOfString: @"T"
                                                                          withString: @" "];
    correctSrtingDate = [correctSrtingDate  stringByReplacingOccurrencesOfString: @"Z"
                                                                      withString: @" "];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString: correctSrtingDate];
}

@end
