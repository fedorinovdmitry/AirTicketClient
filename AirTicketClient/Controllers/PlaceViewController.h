//
//  PlaceViewController.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 27.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "PlaceProtocol.h"

typedef  enum PlaceType{
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol  PlaceViewControllerDelegate <NSObject>
- (void) selectPlace:(id <PlaceProtocol>) place
            withType:(PlaceType)placeType
         andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property  (nonatomic , strong)  id<PlaceViewControllerDelegate> delegate;
- (instancetype) initWithType:(PlaceType)type;

@end
