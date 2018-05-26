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
#import "NotificationCenter.h"
#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketTableViewController ()
    
    @property (nonatomic,strong) NSMutableArray *tickets;
    @property (nonatomic,strong) UITextView *textView;
    @property (nonatomic, strong) UIDatePicker *datePicker;
    @property (nonatomic, strong) UITextField *dateTextField;
    
    @end

@implementation TicketTableViewController {
    BOOL isFavorites;
    TicketTableViewCell *notificationCell;
}
    
-(instancetype)initFavoriteTicketsController{
    self = [super init];
    if(self){
        isFavorites = YES;
        self.tickets = [NSMutableArray new];
        self.title = @"Favorites";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        [self setupDatePicker];
    }
    return self;
}
    
-(instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if  ( self ){
        self.tickets = [NSMutableArray new];
        [_tickets addObjectsFromArray:tickets];
        self.title  =  @"Tickets" ;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [self.tableView registerClass:[TicketTableViewCell  class] forCellReuseIdentifier :TicketCellReuseIdentifier];
        [self setupDatePicker];
    }
    return self;
}
-(void)setupDatePicker{
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.minimumDate = [NSDate date];
    _dateTextField = [[UITextField alloc]init];
    _dateTextField.hidden =YES;
    _dateTextField.inputView = _datePicker;
    UIToolbar *keyboardToolbar = [[UIToolbar alloc]init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _dateTextField.inputAccessoryView = keyboardToolbar;
    [self.view addSubview:_dateTextField];
}
    
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _textView.alpha = 0;
}
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 180) / 2, (self.view.bounds.size.height - 250) / 2, 200, 70)];
    _textView.backgroundColor = UIColor.whiteColor;
    _textView.textColor = [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:0.5f];
    _textView.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:20.0];
    
    _textView.text = @"   you dont'have Favorites Tickets";
    _textView.alpha = 0;
    [self.view addSubview:_textView];
    
    if(isFavorites){
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        if ([_tickets count] > 0){
            [_tickets removeAllObjects];
            [_tickets addObjectsFromArray:[[CoreDataHelper sharedinstance] favorites]];
            
        }else{
            [_tickets addObjectsFromArray:[[CoreDataHelper sharedinstance] favorites]];
        }
        if ([_tickets count] > 0){
            _textView.alpha = 0;
        }
        [self.tableView reloadData];
    }
    
    if (isFavorites && [_tickets count] == 0){
        _textView.alpha = 1;
        
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action with ticket" message:@"What to do with the selected ticket?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    
    if (isFavorites){
        favoriteAction = [UIAlertAction actionWithTitle:@"Delete from Favorites" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            Ticket *ticket = [[Ticket alloc]initWithFavorite:[_tickets objectAtIndex:indexPath.row]];
            [[CoreDataHelper sharedinstance] removeFromFavorite:ticket];
            [_tickets removeObjectAtIndex:indexPath.row];
            if ([_tickets count] == 0){
                [UIView animateWithDuration:2 animations:^{
                    _textView.alpha = 1;
                }];
            }
            [self.tableView reloadData];
        }];
    }else{
        if([[CoreDataHelper sharedinstance]isFavorite:[_tickets objectAtIndex:indexPath.row]]){
            favoriteAction = [UIAlertAction actionWithTitle:@"Delete from Favorites" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[CoreDataHelper sharedinstance] removeFromFavorite:[_tickets objectAtIndex:indexPath.row]];
            }];
        }else{
            favoriteAction = [UIAlertAction actionWithTitle:@"Add to Favorites" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[CoreDataHelper sharedinstance] addToFavorite:[_tickets objectAtIndex:indexPath.row]];
            }];
        }
    }
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Remind" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [_dateTextField becomeFirstResponder];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)doneButtonDidTap:(UIBarButtonItem *)sender{
    if(_datePicker.date &&notificationCell){
        NSString *message = [NSString stringWithFormat:@"%@ - %@ for %@ rub.", notificationCell.ticket.fromFullName, notificationCell.ticket.toFullName, notificationCell.ticket.price];
        NSURL *imageURL;
        if(notificationCell.airlineLogoView.image){
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
            if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
                UIImage *logo = notificationCell.airlineLogoView.image;
                NSData *pngData = UIImagePNGRepresentation(logo);
                [pngData writeToFile:path atomically:YES];
            }
            imageURL = [NSURL fileURLWithPath:path];
        }
        Notification notification = NotificationMake(@"Remind for ticket", message, _datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification:notification];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sucsess" message:[NSString stringWithFormat:@"We will remind you of the ticket - %@", _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.view endEditing:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}
    
    
    @end
