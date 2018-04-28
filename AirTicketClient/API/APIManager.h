//
//  APIManager.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

typedef struct SearchRequest{
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
}SearchRequest;

@interface APIManager : NSObject

+(instancetype)sharedInstance;
//-(void)cityForCurrentIP:(void (ˆ)(City *city))completion;
-(void)cityForCurrentIP:( void  (^)(City *city))completion;
-(void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;

@end

