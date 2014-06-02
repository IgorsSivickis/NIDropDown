//
//  NIViewController.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface NIViewController : UIViewController <NIDropDownDelegate>
{
    IBOutlet UIButton *buttonSelect;   
    NIDropDown *dropDown;
}

@property (retain, nonatomic) IBOutlet UIButton *buttonSelect;
@property (retain, nonatomic) IBOutlet UIButton *transpButton;
- (IBAction)selectClicked:(id)sender;


-(void)rel;
@end
