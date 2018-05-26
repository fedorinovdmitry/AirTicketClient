//
//  TabBarController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 17.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "TabBarController.h"
#import "StartingViewController.h"
#import "MapViewController.h"
#import "TicketTableViewController.h"
#import "NSString+Localize.h"

@interface TabBarController ()

@end

@implementation TabBarController

-(instancetype)init{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blueColor];
    }
    return self;
}

-(NSArray<UIViewController*>*)createViewControllers{
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    StartingViewController *startViewController = [[StartingViewController alloc]init];
    startViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"search_tab".localize image:[UIImage imageNamed:@"search1"] selectedImage:[UIImage imageNamed:@"search_selected1"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:startViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc]init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"map_tab".localize image:[UIImage imageNamed:@"map1"] selectedImage:[UIImage imageNamed:@"map_selected1"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    TicketTableViewController *favoriteViewController = [[TicketTableViewController alloc] initFavoriteTicketsController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"favorites_tab".localize image:[UIImage imageNamed:@"favorite1"] selectedImage:[UIImage imageNamed:@"favorite_selected1"]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
    [controllers addObject:favoriteNavigationController];
    
    
    
    return controllers;
}


@end
