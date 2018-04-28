//
//  Airport.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>
#import "PlaceProtocol.h"

@interface Airport : NSObject <PlaceProtocol>

@property (nonatomic,strong) NSString *cityCode;
@property (nonatomic,getter=isFlightable) BOOL flightable;

@end
