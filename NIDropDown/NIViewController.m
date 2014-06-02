//
//  NIViewController.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController ()

@property(nonatomic, retain) NSArray *itemsArray;

@end

@implementation NIViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.itemsArray = [NSArray arrayWithObjects:@"Item 0", @"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6", @"Item 7", @"Item 8", @"Item 9", nil];
  
    
    dropDown = [[NIDropDown alloc]initTable:self.buttonSelect itemsArray:self.itemsArray];
    
    [self.buttonSelect setTitle:[self.itemsArray objectAtIndex:0] forState:UIControlStateNormal];
    self.buttonSelect.layer.borderWidth = 1;
    self.buttonSelect.layer.borderColor = [[UIColor blackColor] CGColor];

}

- (void)viewDidUnload
{
    self.buttonSelect = nil;
    [self setButtonSelect:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
//    [buttonSelect release];
//    [super dealloc];
}

- (IBAction)transpButton:(id)sender
{
    [dropDown hideDropDown:self.buttonSelect];
    [self rel];
}

- (IBAction)selectClicked:(id)sender
{
        if ([self.itemsArray count] < 4){
            [self blockScreen];
            CGFloat listHeight = self.buttonSelect.frame.size.height * [self.itemsArray count];
            [dropDown showDropDown:sender listHeight:&listHeight direction:@"down"];
            dropDown.delegate = self;
            
        }else if ([self.itemsArray count] >= 4){
            [self blockScreen];
            CGFloat listHeight = self.buttonSelect.frame.size.height * 4;
            [dropDown showDropDown:sender listHeight:&listHeight direction:@"down"];
            dropDown.delegate = self;
        }
    else {
        [dropDown hideDropDown:sender];
        [self rel];

    }
}

-(void)blockScreen
{
    [self.view insertSubview:self.transpButton atIndex:[[self.view subviews] count]-2];
//    [self.view addSubview:self.transpButton];
    
    self.transpButton.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.transpButton setAlpha:0.0];
    self.transpButton.layer.cornerRadius = 0.03f;
    [self.transpButton setTintColor:[UIColor colorWithWhite:1 alpha:0.0]];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.transpButton setAlpha:0.4];
    [self.transpButton setHidden:NO];
    
    [UIView commitAnimations];
}



- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}

-(void)rel
{
 //       dropDown = nil;
    
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [self.transpButton setAlpha:0.0];
        [UIView commitAnimations];
}


@end
