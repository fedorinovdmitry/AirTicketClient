//
//  DataManager.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType{
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
}DataSourceType;
@interface DataManager: NSObject
+(instancetype)sharedInstance;
-(void) loadData;
-(City*)cityForIATA:(NSString  *)iata;
@property (nonatomic,strong,readonly)NSArray *countries;
@property (nonatomic,strong,readonly)NSArray *cities;
@property (nonatomic,strong,readonly)NSArray *airports;

@end
