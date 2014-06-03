//
//  NIDropDown.m
//  NIDropDown
//


#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"


@interface NIDropDown ()

/*!
  Table which shows items from array.
 */
@property(nonatomic, strong) UITableView *table;

/*!
 Button opens drop down menu.
 */
@property(nonatomic, strong) UIButton *menuButton;

/*!
 Transparent button which blocks screen while menu appears on screen.
 */
@property(nonatomic, strong) UIButton *blockButton;

/*!
 This array contains a list of items to be displayed in table.
 */
@property(nonatomic, retain) NSArray *list;


@end

//  Maximum items shown in table without scrolling.
#define MAX_ITEMS_IN_TABLE                  5

// Distance between menu button and table in pixels.
#define TABLE_FROM_BUTTON_OFFSET            2

// Difference between button and table cell height in pixels.
#define TABLE_AND_CELL_HEIGHT_DIFFERENCE    7

@implementation NIDropDown


-(id)initTable:(UIButton *)button superView:(UIView *)sView itemsArray:(NSArray *)array
{
    //  First drop down menu initialization.
    
    self.menuButton = button;
    self.table = (UITableView *) [super init];
    self.list = [NSArray arrayWithArray:array];
    
    if (self) {
        
   //   Create transparent button for screen blocking while drop down menu shown on screen.
        
        self.blockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.blockButton addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
        
        self.blockButton.frame = sView.frame;
        [self.blockButton setAlpha:0.0];
        self.blockButton.layer.cornerRadius = 0.03f;
        [self.blockButton setTintColor:[UIColor colorWithWhite:1 alpha:0.0]];
        [sView addSubview:self.blockButton];
        
   //   If array with items not empty, set title for button which shows menu.
        
        if ([self.list count]){
            [self.menuButton setTitle:[self.list objectAtIndex:0] forState:UIControlStateNormal];
        }else{
            [self.menuButton setTitle:@"Empty array :(" forState:UIControlStateNormal];
        }
        [self.menuButton setBackgroundColor:[UIColor lightGrayColor]];
        self.menuButton.layer.borderWidth = 1;
        self.menuButton.layer.borderColor = [[UIColor blackColor] CGColor];
        
    //  Create table for menu according button size and position.
        
        CGRect buttonFrame = button.frame;
        
        self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height+TABLE_FROM_BUTTON_OFFSET, buttonFrame.size.width, 0);
    
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

-(void)blockScreen
{
//  Block screen with transparent button when drop down menu appears on screen.
    
    self.blockButton.frame = self.blockButton.superview.bounds;
    [self.blockButton setBackgroundColor:[UIColor grayColor]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.blockButton setAlpha:0.4];
    [self.blockButton setHidden:NO];
    
    [UIView commitAnimations];
}


-(void)showDropDown
{
  // Opens menu with defined items count in table which can be shown without scroll.
    
    CGRect buttonFrame = self.menuButton.frame;
    CGFloat listHeight = buttonFrame.size.height+TABLE_AND_CELL_HEIGHT_DIFFERENCE;
    
    if ([self.list count] < MAX_ITEMS_IN_TABLE){
       listHeight *= [self.list count];
    } else if ([self.list count] >= MAX_ITEMS_IN_TABLE){
       listHeight *= MAX_ITEMS_IN_TABLE;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height+TABLE_FROM_BUTTON_OFFSET, buttonFrame.size.width, listHeight);
    
    self.table.frame = CGRectMake(0, 0, buttonFrame.size.width, listHeight);
    [UIView commitAnimations];
}

-(void)hideMenu
{
 // Hide transparent button and close menu with animation.
    
    CGRect buttonFrame = self.menuButton.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [self.blockButton setAlpha:0.0];
    self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height+TABLE_FROM_BUTTON_OFFSET, buttonFrame.size.width, 0);
    self.table.frame = CGRectMake(0, 0, buttonFrame.size.width, 0);
    
    [UIView commitAnimations];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 //  Set rows height according button height.
    return self.menuButton.frame.size.height+TABLE_AND_CELL_HEIGHT_DIFFERENCE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   Fill table with data.
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }

    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];        
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = view;
    
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.menuButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    [self hideMenu];
    
    if ([self.delegate respondsToSelector:@selector(niDropDownDelegateMethod:)]){        
        [self dropDownDelegate];
    } 
}

- (void) dropDownDelegate
{
    [self.delegate niDropDownDelegateMethod:self];
}

@end
