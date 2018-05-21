//
//  TicketTableViewController.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketTableViewController: UITableViewController

-(instancetype)initWithTickets:(NSArray  *)tickets;
-(instancetype)initFavoriteTicketsController;
@end
