//
//  PlaceViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 27.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "PlaceViewController.h"
#import "NSString+Localize.h"

#define ReuseIdentifier @"CellIdentifier"

@interface  PlaceViewController () <UISearchResultsUpdating>

@property (nonatomic) PlaceType placeType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *currentArray;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;


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
    
    [self configSearchController];
    [self configTableView];
    [self configSegmentControl];
    
    
    
    
    self.title = (_placeType == PlaceTypeDeparture) ? @"main_from".localize : @"main_to".localize;
    
}
-(void)configSearchController{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    _searchArray = [NSArray new];
}

-(void)configTableView{
    _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if(@available(iOS 11.0, *)){
        self.navigationItem.searchController = _searchController;
    }else{
        _tableView.tableHeaderView = _searchController.searchBar;
    }
    [self.view addSubview:_tableView];
}

-(void)configSegmentControl{
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"cities_seg".localize,  @"airpotrs_seg".localize]];
    [_segmentedControl addTarget:self
                          action:@selector(changeSource)
                forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor blueColor];
    
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
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
#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if(searchController.searchBar.text){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
        _searchArray = [_currentArray filteredArrayUsingPredicate:predicate];
        [_tableView reloadData];
    }
}
-(BOOL)isSearching{
    return _searchController.isActive && [_searchArray count]>0;
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    if([self isSearching]){
        return [_searchArray count];
    }
    return [_currentArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Superclarendon-Light" size:11.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0]];
    
    id <PlaceProtocol> place = [self isSearching] ? [_searchArray objectAtIndex:indexPath.row] : [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.code;
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = 0;
    
    cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -10 - self.view.bounds.size.width, 30, 0);
    
    
    [UIView animateWithDuration:0.55 animations:^{
        cell.alpha = 1;
        cell.layer.transform = CATransform3DIdentity;
    }];
    
    
    
    
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) +  1;
    if([self isSearching]){
        [self.delegate selectPlace:_searchArray[indexPath.row] withType:_placeType                                                                                                                                                             andDataType:dataType];
        _searchController.active = NO;
    }else{
        [self.delegate selectPlace:_currentArray[indexPath.row] withType:_placeType                                                                                                                                                             andDataType:dataType];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}



@end
