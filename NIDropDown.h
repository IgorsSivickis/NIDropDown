//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
}

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(UIButton *)button;
-(void)showDropDown:(UIButton *)button listHeight:(CGFloat *)height direction:(NSString *)direction;
-(id)initTable:(UIButton *)button itemsArray:(NSArray *)array;
@end
