//
//  NIViewController.m
//  NIDropDown
//
//


#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController ()


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
    
    // Create array of items and
    // NIDropDown instance initialization.
    
    NSArray *itemsArray = [NSArray arrayWithObjects:@"Item 0", @"Item 1",@"Item 2", @"Item 3",@"Item 4", @"Item 5",@"Item 6", @"Item 7",@"Item 8", @"Item 9", nil];
    
    dropDown = [[NIDropDown alloc]initTable:self.buttonSelect superView:self.view itemsArray:itemsArray];
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


- (IBAction)selectClicked:(id)sender
{    
        [dropDown blockScreen];
        [dropDown showDropDown];
        dropDown.delegate = self;
}


// Delegate for DropDown class.

- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
   // [dropDown hideMenu];   
}



@end
