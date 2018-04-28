//
//  APIManager.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface APIManager : NSObject

+(instancetype)sharedInstance;
//-(void)cityForCurrentIP:(void (ˆ)(City *city))completion;
-(void)cityForCurrentIP:( void  (^)(City *city))completion;

@end

