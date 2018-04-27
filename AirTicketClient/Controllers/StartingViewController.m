//
//  ViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "StartingViewController.h"

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

@interface StartingViewController () <PlaceViewControllerDelegate>

@property (nonatomic, strong) UIButton *departureButton;
@property (nonatomic, strong) UIButton *arrivalButton;
@property (nonatomic) SearchRequest searchRequest;

@end

@implementation StartingViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [[DataManager  sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Find";
//    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object: nil];
    [self addDepartureButton];
    [self addArrivalButton];
    
    
    
}
-(void)addDepartureButton{
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:@"From" forState:UIControlStateNormal];
    [_departureButton.titleLabel setFont:[UIFont fontWithName:@"Snell Roundhand" size:22.0]];
    
    _departureButton.tintColor = [UIColor blackColor];
    _departureButton.frame = CGRectMake(30.0, 140.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _departureButton.backgroundColor = [UIColor colorWithRed:116.0f/255.0f
                                                       green:186.0f/255.0f
                                                        blue:242.0f/255.0f
                                                       alpha:1.0f];
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_departureButton];
}
-(void)addArrivalButton{
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:@"To" forState:UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor blackColor];
    [_arrivalButton.titleLabel setFont:[UIFont fontWithName:@"Snell Roundhand" size:22.0]];
    _arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(_departureButton.frame)+50, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _arrivalButton.backgroundColor = [UIColor colorWithRed:116.0f/255.0f
                                                     green:186.0f/255.0f
                                                      blue:242.0f/255.0f
                                                     alpha:1.0f];
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_arrivalButton];
}
-(void)placeButtonDidTap:(UIButton *)sender{
    PlaceViewController *placeViewController;
    if([sender isEqual:_departureButton]){
        placeViewController = [[PlaceViewController alloc] initWithType:PlaceTypeDeparture];
    }else{
        placeViewController = [[PlaceViewController alloc] initWithType:PlaceTypeArrival];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController:placeViewController animated:YES];
}
//-(void) dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self  name:kDataManagerLoadDataDidComplete object:nil];
//}
//- (void)loadDataComplete{
//    self.view.backgroundColor = [UIColor yellowColor];
//}


#pragma mark - PlaceViewControllerDelegate

-(void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType{
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton:(placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton];
}

-(void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button{
    NSString *title;
    NSString *iata;
    
    if(dataType == DataSourceTypeCity){
        City *city = (City *)place;
        title = city.name;
        iata = city.code;
    }else if(dataType == DataSourceTypeAirport){
        Airport *airport = (Airport*)place;
        title = airport.name;
        iata = airport.cityCode;
    }
    if (placeType == PlaceTypeDeparture){
        _searchRequest.origin = iata;
    }else {
        _searchRequest.destionation = iata;
    }
    [button setTitle: title forState: UIControlStateNormal];
}








@end
