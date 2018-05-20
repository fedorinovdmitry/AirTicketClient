//
//  TicketTableViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 28.04.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "TicketTableViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"
#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()

@property (nonatomic,strong) NSMutableArray *tickets;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation TicketTableViewController {
    BOOL isFavorites;
}

-(instancetype)initFavoriteTicketsController{
    self = [super init];
    if(self){
        isFavorites = YES;
        self.tickets = [NSMutableArray new];
        self.title = @"Favorites";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

-(instancetype)initWithTickets:(NSArray *)atickets {
    self = [super init];
    if  ( self ){
        self.tickets = [NSMutableArray new];
        [_tickets addObjectsFromArray:atickets];
        self.title  =  @"Tickets" ;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [self.tableView registerClass:[TicketTableViewCell  class] forCellReuseIdentifier :TicketCellReuseIdentifier];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(isFavorites){
        self.navigationController.navigationBar.prefersLargeTitles = YES;
//        NSArray *favorites = [[CoreDataHelper sharedinstance] favorites];
//        NSMutableArray *favTicket = [[NSMutableArray alloc] init];
//        for (FavoriteTicket *i in favorites){
//            Ticket *ticket = [[Ticket alloc] initWithFavorite:i];
//            [favTicket addObject:ticket];
//        }
//        _tickets = favTicket;
        
        [_tickets addObjectsFromArray:[[CoreDataHelper sharedinstance] favorites]];
        if ([_tickets count] > 0){
            _textView.alpha = 0;
        }
        [self.tableView reloadData];
    }
    if (isFavorites && [_tickets count] == 0){
        _textView = [[UITextView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 180) / 2, (self.view.bounds.size.height - 250) / 2, 200, 70)];
        _textView.backgroundColor = UIColor.whiteColor;
        _textView.textColor = [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:0.5f];
        _textView.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0];
        
        _textView.text = @"   you dont'have Favorites Tickets";
        
        [self.view addSubview:_textView];
    }
    
}
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//     return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier :TicketCellReuseIdentifier forIndexPath :indexPath];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:0.5f];
    if(isFavorites){
        cell.ticket = [[Ticket alloc]initWithFavorite:[_tickets objectAtIndex:indexPath.row]];
    }else{
        cell.ticket  = _tickets[indexPath.row];
    }
    
    
    cell.selectedBackgroundView =  customColorView;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isFavorites){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action with ticket" message:@"What to do with the selected ticket?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *favoriteAction;
        favoriteAction = [UIAlertAction actionWithTitle:@"Delete from Favorites" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                Ticket *ticket = [[Ticket alloc]initWithFavorite:[_tickets objectAtIndex:indexPath.row]];
                [[CoreDataHelper sharedinstance] removeFromFavorite:ticket];
                [_tickets removeObjectAtIndex:indexPath.row];
                if ([_tickets count] == 0){
                    _textView.alpha = 1;
                }
                [self.tableView reloadData];
            }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:favoriteAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action with ticket" message:@"What to do with the selected ticket?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if([[CoreDataHelper sharedinstance]isFavorite:[_tickets objectAtIndex:indexPath.row]]){
        favoriteAction = [UIAlertAction actionWithTitle:@"Delete from Favorites" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedinstance] removeFromFavorite:[_tickets objectAtIndex:indexPath.row]];
        }];
    }else{
        favoriteAction = [UIAlertAction actionWithTitle:@"Add to Favorites" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedinstance] addToFavorite:[_tickets objectAtIndex:indexPath.row]];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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
