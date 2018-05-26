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
    startViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Find Tickets" image:[UIImage imageNamed:@"search1"] selectedImage:[UIImage imageNamed:@"search_selected1"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:startViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc]init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map price" image:[UIImage imageNamed:@"map1"] selectedImage:[UIImage imageNamed:@"map_selected1"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    TicketTableViewController *favoriteViewController = [[TicketTableViewController alloc] initFavoriteTicketsController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"favorite1"] selectedImage:[UIImage imageNamed:@"favorite_selected1"]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
    [controllers addObject:favoriteNavigationController];
    
    
    
    return controllers;
}


@end
