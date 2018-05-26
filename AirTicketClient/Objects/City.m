//
//  City.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "City.h"

@implementation City 

@synthesize timezone, countryCode, name, code, coordinate, translations;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        timezone = [dictionary valueForKey:@"time_zone"];
        translations =[dictionary valueForKey:@"name_translations"];
        name = [dictionary valueForKey:@"name"];
        countryCode = [dictionary valueForKey:@"country_code"];
        code = [dictionary valueForKey:@"code"];
        NSDictionary *coords = [dictionary valueForKey:@"coordinates"];
        if(coords && ![coords isEqual:[NSNull null]]){
            NSNumber *lon = [coords valueForKey:@"lon"];
            NSNumber *lat = [coords valueForKey:@"lat"];
            if(![lon isEqual:[NSNull null]] && ![lat isEqual:[NSNull null]]){
                coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
        [self localizeName];
    }
    return self;
}
-(void)localizeName{
    if(!translations) return;
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeid = [locale.localeIdentifier substringToIndex:2];
    if(localeid){
        if([translations valueForKey: localeid]){
            self.name = [translations valueForKey:localeid];
        }
    }
}


@end
