//
//  NIViewController.h
//  NIDropDown
//
//  


#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface NIViewController : UIViewController <NIDropDownDelegate>
{
    IBOutlet UIButton *buttonSelect;   
    NIDropDown *dropDown;
}

/*
 Button which shows drop down menu.
 */
@property (retain, nonatomic) IBOutlet UIButton *buttonSelect;

-(IBAction)selectClicked:(id)sender;

@end
