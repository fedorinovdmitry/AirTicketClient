//
//  ChooseViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 05.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "ChooseViewController.h"

@interface ChooseViewController ()

@property (strong, nonatomic) UIButton *mapButton;
@property (strong, nonatomic) UIButton *interfaceButton;

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_mapButton setTitle:@"Go To Map" forState:UIControlStateNormal];
    _mapButton.tintColor = [UIColor blackColor];
    _mapButton.frame = CGRectMake(100, 200, 200, 60.0);
    _mapButton.layer.cornerRadius = 25.0;
    _mapButton.backgroundColor = UIColor.orangeColor;
    [_mapButton addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mapButton];
    
    _interfaceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_interfaceButton setTitle:@"Go To Interface" forState:UIControlStateNormal];
    _interfaceButton.tintColor = [UIColor whiteColor];
    _interfaceButton.frame = CGRectMake(100, 350, 200, 60.0);
    _interfaceButton.layer.cornerRadius = 25.0;
    _interfaceButton.backgroundColor = UIColor.blueColor;
    [_interfaceButton addTarget:self action:@selector(goToInterface:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_interfaceButton];
    
    
    // Do any additional setup after loading the view.
}

-(void)goToMap:(UIButton *)sender{
    MapViewController *mapViewcontroller = [[MapViewController alloc] init];
    [self.navigationController showViewController:mapViewcontroller sender: self];
}
-(void)goToInterface:(UIButton *)sender{
    StartingViewController *startingViewController = [[StartingViewController alloc] init];
    [self.navigationController showViewController:startingViewController sender: self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
