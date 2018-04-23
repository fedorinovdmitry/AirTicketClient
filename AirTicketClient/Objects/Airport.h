//
//  Airport.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>

@interface Airport : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *timezone;
@property (nonatomic,strong) NSDictionary *translations;
@property (nonatomic,strong) NSString *countryCode;
@property (nonatomic,strong) NSString *cityCode;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,getter=isFlightable) BOOL flightable;
@property (nonatomic) CLLocationCoordinate2D  coordinate;
-(instancetype) initWithDictionary:( NSDictionary * )dictionary;
@end
