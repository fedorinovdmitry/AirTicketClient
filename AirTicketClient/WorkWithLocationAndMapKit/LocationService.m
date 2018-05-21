//
//  LocationService.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 04.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "LocationService.h"
//#import "ProgressView.h"



@interface LocationService() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation LocationService

-(instancetype)init{
    self = [super init];
    if(self){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager startUpdatingLocation];
    }else if (status != kCLAuthorizationStatusNotDetermined){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"we can't find your current location" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Close" style:(UIAlertActionStyleDefault) handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if(!_currentLocation){
        _currentLocation = [locations firstObject];
        [_locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceDidUpdateCurrentLocation object:_currentLocation];
        
    }
}

@end
