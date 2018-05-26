//
//  TicketTableViewCell.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"

@interface TicketTableViewCell :  UITableViewCell
    
@property (nonatomic,  strong ) Ticket *ticket;
@property ( nonatomic ,  strong )  UIImageView  *airlineLogoView;
    
@end
