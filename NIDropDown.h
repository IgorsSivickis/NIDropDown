//
//  NIDropDown.h
//  NIDropDown
//
//

#import <UIKit/UIKit.h>

/*!
 Class which shows Drop down menu with items from array.
 */
@class NIDropDown;
@protocol NIDropDownDelegate  <NSObject>
-(void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <NIDropDownDelegate> delegate;

/*!
 Block screen while drop down menu appears on screen.
 */
-(void)blockScreen;

/*!
 Close drop down menu and unblock screen.
 */
-(void)hideMenu;

/*!
 Shows drop down menu.
 */
-(void)showDropDown;

/*!
 First table initialization, set title for menu button and create transparent button for screen blocking.
 @param button Button which will open drop down menu.
 @param sView  Superview, where menu and block button will be added.
 @param array  Array of episodes to be displayed in table.
 */
-(id)initTable:(UIButton *)button superView:(UIView *)sView itemsArray:(NSArray *)array;
@end
