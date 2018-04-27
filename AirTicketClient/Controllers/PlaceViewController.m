//
//  PlaceViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 27.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "PlaceViewController.h"


#define ReuseIdentifier @"CellIdentifier"

@interface  PlaceViewController ()

@property (nonatomic) PlaceType placeType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray  *currentArray;
@end

@implementation PlaceViewController

-(instancetype) initWithType:(PlaceType)type
{
    self = [ super init];
    if  (self)
    {
        _placeType = type;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self. navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Cities",  @"Airports"]];
    [_segmentedControl addTarget:self
                          action:@selector(changeSource)
                forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor blueColor];
    
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
    
    if (_placeType == PlaceTypeDeparture){
        self.title =  @"From";
    }
    else{
        self.title =  @"To";
    }
    
}

- (void) changeSource {
    switch (_segmentedControl.selectedSegmentIndex){
        case  0:
            _currentArray = [[DataManager sharedInstance] cities];
            break;
        case  1:
            _currentArray = [[DataManager sharedInstance] airports];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return [_currentArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle                 reuseIdentifier:ReuseIdentifier];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Superclarendon-Light" size:11.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0]];
    if (_segmentedControl.selectedSegmentIndex ==  0) {
        City *city = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        
        cell.detailTextLabel.text = city.code;
        
    }else if (_segmentedControl.selectedSegmentIndex ==  1) {
        Airport *airport = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) +  1;
    
    [self.delegate selectPlace:[_currentArray objectAtIndex:indexPath.row] withType:_placeType                                                                                                                                                             andDataType:dataType];
    [self.navigationController popViewControllerAnimated: YES];
}

@end
