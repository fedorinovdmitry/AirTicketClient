//
//  ViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "StartingViewController.h"
#define BACKGROUNDCOLORBUTTON [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:1.0f]
#define BUTTON_FONT_STYLE_SIZE [UIFont fontWithName:@"SnellRoundhand-Bold" size:25.0]


@interface StartingViewController () <PlaceViewControllerDelegate>

@property (nonatomic, strong) UIView *placeContainerView;
@property (nonatomic, strong) UIButton *departureButton;
@property (nonatomic, strong) UIButton *arrivalButton;
@property (nonatomic) SearchRequest searchRequest;
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation StartingViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [[DataManager  sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Find";
//    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object: nil];
    
    
    [self addPlaceContainerView];
    [self addSearchButton];
//    [self addArrivalButton];
    
    
    
}

-(void)addPlaceContainerView{
    _placeContainerView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 110.0, [UIScreen mainScreen].bounds.size.width - 40.0, 200)];
    _placeContainerView.backgroundColor = [UIColor colorWithRed:170.0f/255.0f
                                                          green:235.0f/255.0f
                                                           blue:250.0f/255.0f
                                                          alpha:0.8f];
    _placeContainerView.layer.shadowColor = [[BACKGROUNDCOLORBUTTON
                                              colorWithAlphaComponent:0.3] CGColor];
    _placeContainerView.layer.shadowOffset = CGSizeZero;
    _placeContainerView.layer.shadowRadius = 20.0;
    _placeContainerView.layer.shadowOpacity = 1.0;
    _placeContainerView.layer.cornerRadius = 6.0;
    [self addDepartureButton];
    [self addArrivalButton];
    [self.view addSubview:_placeContainerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object :nil];
}

-(void)addDepartureButton{
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:@"From" forState:UIControlStateNormal];
    [_departureButton.titleLabel setFont:BUTTON_FONT_STYLE_SIZE];
    _departureButton.tintColor = [UIColor whiteColor];
    
    _departureButton.frame = CGRectMake((_placeContainerView.frame.size.width - (_placeContainerView.frame.size.width - 125.0)) / 2, 20, _placeContainerView.frame.size.width - 125.0, 60.0);
    _departureButton.backgroundColor = BACKGROUNDCOLORBUTTON;
    _departureButton.layer.cornerRadius = 25.0;
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.placeContainerView addSubview:_departureButton];
}
-(void)addArrivalButton{
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:@"To" forState:UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor whiteColor];
    [_arrivalButton.titleLabel setFont:BUTTON_FONT_STYLE_SIZE];
    _arrivalButton.frame = CGRectMake((_placeContainerView.frame.size.width - (_placeContainerView.frame.size.width - 125.0)) / 2, CGRectGetMaxY(_departureButton.frame) + 40,  _placeContainerView.frame.size.width - 125.0, 60.0);
    _arrivalButton.layer.cornerRadius = 25.0;
    _arrivalButton.backgroundColor = BACKGROUNDCOLORBUTTON;
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.placeContainerView addSubview:_arrivalButton];
}
-(void)addSearchButton{
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton.titleLabel setFont:BUTTON_FONT_STYLE_SIZE];
    [_searchButton setTitle: @"Let's Find" forState: UIControlStateNormal];
    _searchButton.tintColor = BACKGROUNDCOLORBUTTON;
    _searchButton.frame = CGRectMake((_placeContainerView.frame.size.width - (_placeContainerView.frame.size.width - 125.0)) / 2 + 20, CGRectGetMaxY(_placeContainerView.frame) + 50, _placeContainerView.frame.size.width - 125.0,  40.0);
    _searchButton.backgroundColor = [UIColor whiteColor];
    _searchButton.layer.cornerRadius = 25.0;
    _searchButton.titleLabel.font = [UIFont systemFontOfSize: 20.0 weight: UIFontWeightBold];
    [self.view addSubview: _searchButton];


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
-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kDataManagerLoadDataDidComplete
                                                  object:nil];
}
- (void)dataLoadedSuccessfully{
    [[APIManager sharedInstance] cityForCurrentIP: ^(City  *city){
        [self setPlace:city withDataType: DataSourceTypeCity andPlaceType:PlaceTypeDeparture forButton: _departureButton];
    }];
}


#pragma mark - PlaceViewControllerDelegate

-(void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType{
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton:(placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton];
}

-(void)setPlace:(id <PlaceProtocol>)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button{
    NSString *title;
    NSString *iata;
    
    title = place.name;
//    iata = (dataType == DataSourceTypeCity) ? place.code : ((^)(id place){
//        Airport *airport = (Airport*)place;
//        return airport.cityCode;
//    });
//    double v = (double ^(double firstValue, double secondValuexf) {
//        return firstValue * secondValue;
//    });
    
    if(dataType == DataSourceTypeCity){
        iata = place.code;
    }else if(dataType == DataSourceTypeAirport){
        Airport *airport = (Airport*)place;
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
