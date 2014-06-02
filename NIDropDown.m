//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *buttonSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation NIDropDown


-(id)initTable:(UIButton *)button itemsArray:(NSArray *)array
{
    self.buttonSender = button;    
    self.table = (UITableView *) [super init];
    
    if (self) {
        // Initialization code
        CGRect buttonFrame = button.frame;
        self.list = [NSArray arrayWithArray:array];
        
        self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, 0);
    
        self.layer.masksToBounds = NO;
        self.layer.borderWidth = 1;
        
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, 0)];
        self.table.delegate = self;
        self.table.dataSource = self;
        
        self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.table.separatorColor = [UIColor grayColor];
        [button.superview addSubview:self];
        [self addSubview:self.table];
        
    }
    return self;
}

- (void)showDropDown:(UIButton *)button listHeight:(CGFloat *)height direction:(NSString *)direction
{
    self.buttonSender = button;
    animationDirection = direction;

        CGRect buttonFrame = button.frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y-*height, buttonFrame.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height, buttonFrame.size.width, *height);
        }
        self.table.frame = CGRectMake(0, 0, buttonFrame.size.width, *height);
        [UIView commitAnimations];
    
    NSLog(@"%@",[self.list description]);
    
}

-(void)hideDropDown:(UIButton *)button
{
    
    CGRect buttonFrame = button.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height, buttonFrame.size.width, 0);
    }
    self.table.frame = CGRectMake(0, 0, buttonFrame.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return self.buttonSender.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }

    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
        
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = view;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideDropDown:self.buttonSender];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.buttonSender setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    [self myDelegate];
}

- (void) myDelegate
{
    [self.delegate niDropDownDelegateMethod:self];
}

-(void)dealloc
{
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
