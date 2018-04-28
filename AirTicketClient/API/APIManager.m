//
//  APIManager.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "APIManager.h"

#define API_TOKEN @"94240481927460452d16b650809175dd"
#define API_URL_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="

@implementation APIManager

+(instancetype)sharedInstance
{
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc]init];
    });
    return instance;
}

-(void)cityForCurrentIP:(void (^)(City  *city))completion{
    
    [self IPAddressWithCompletion :^(NSString  *ipAddress){
         [self load :[NSString  stringWithFormat : @"%@%@" , API_URL_CITY_FROM_IP, ipAddress]
     withCompletion :^( id   _Nullable  result){
              NSDictionary  *json = result;
              NSLog(@"ns log from load %@",json);
              NSString  *iata = [json  valueForKey:   @"iata" ];
              if(iata){
                  City *city = [[DataManager sharedInstance] cityForIATA: iata];
                  if  (city){
                      dispatch_async ( dispatch_get_main_queue (), ^{
                          completion(city);
                      });
                  }
              }
          }];
     }];
}
-(void)IPAddressWithCompletion:(void  (^)(NSString  *ipAddress))completion{
    [self load :API_URL_IP_ADDRESS  withCompletion :^( id _Nullable result){
         NSDictionary  *json = result;
         NSLog(@"ns log from IPAddress %@",json);
         completion([json valueForKey :@"ip"]);
     }];
}
- (void)load:(NSString  *)urlString withCompletion:(void  (^)(id _Nullable result))completion{
    dispatch_async(dispatch_get_main_queue (), ^{
    [[UIApplication   sharedApplication]  setNetworkActivityIndicatorVisible : YES]; });
    [[[NSURLSession  sharedSession]   dataTaskWithURL:[NSURL  URLWithString :urlString]
                                    completionHandler:^(NSData *  _Nullable data,  NSURLResponse *  _Nullable response,  NSError * _Nullable  error){
        dispatch_async ( dispatch_get_main_queue (), ^{
            [[UIApplication   sharedApplication] setNetworkActivityIndicatorVisible : NO];
        });
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume];
}

@end
