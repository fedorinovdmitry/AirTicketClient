//
//  TicketTableViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "TicketTableViewController.h"
#import "TicketTableViewCell.h"
#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()
@property  ( nonatomic ,  strong )  NSArray  *tickets;
@end

@implementation TicketTableViewController

- (instancetype)initWithTickets:( NSArray  *)tickets {
    self  = [ super   init ];
    if  ( self ){
        _tickets  = tickets;
        self.title  =  @"Tickets" ;
        self.tableView.separatorStyle  =  UITableViewCellSeparatorStyleNone ;
        [self.tableView  registerClass:[TicketTableViewCell  class] forCellReuseIdentifier :TicketCellReuseIdentifier];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets . count ;
}
- (UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier :TicketCellReuseIdentifier forIndexPath :indexPath];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:0.5f];
    cell.ticket  = _tickets[indexPath.row];
    
    cell.selectedBackgroundView =  customColorView;
    
    
    return cell;
}
- ( CGFloat )tableView:( UITableView  *)tableView heightForRowAtIndexPath:( NSIndexPath  *)indexPath {
    return 140.0;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = 0;
  
    cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -10 - self.view.bounds.size.width, 30, 0);
    [UIView animateWithDuration:indexPath.row animations:^{
        cell.alpha = 1;
        cell.layer.transform = CATransform3DIdentity;
    }];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
     Configure the cell...
 
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
