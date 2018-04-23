//
//  ViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 23.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "StartingViewController.h"

@interface StartingViewController ()

@end

@implementation StartingViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [[DataManager  sharedInstance] loadData];
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object: nil];
}
-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:kDataManagerLoadDataDidComplete object:nil];
}
- (void)loadDataComplete{
    self.view.backgroundColor = [UIColor yellowColor];
}




@end
