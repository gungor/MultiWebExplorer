
#import "AutocompletionTableView.h"
#import "ViewController.h"
#import "GoogleSuggestionReceiver.h"

@interface AutocompletionTableView ()
@property (nonatomic, strong) NSMutableArray *suggestionOptions; // of selected NSStrings
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic, strong) UIFont *font; // will copy style from assigned textfield
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation AutocompletionTableView



@synthesize suggestionsDictionary = _suggestionsDictionary;
@synthesize suggestionOptions = _suggestionOptions;
@synthesize font = _font;

#pragma mark - Initialization
- (UITableView *)initWithTextField:(UITextField *)textField : (UIView *) container : (UIWebView *) webView ;
{
    CGRect frame = CGRectMake(textField.frame.origin.x+1, textField.frame.origin.y+textField.frame.size.height, textField.frame.size.width-1, 120);

    self.font = textField.font;
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)];
    v.backgroundColor = [UIColor clearColor];
    v.layer.zPosition = 2.0f;
    
    self.layer.zPosition = 2.0f;
    
    [self setTableFooterView:v];
    self.hidden = YES;
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    self.webView = webView;
    
    [container addSubview:self];
    
    
    return self;
}

-(void)loadBySearch: (NSString *)searchString
{
    [GoogleSuggestionReceiver loadBySearch:searchString : self.webView];
}

- (AutocompletionTableView *)autoCompleter
{
    return self;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestionOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }

    cell.textLabel.font = self.font;
    
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    cell.textLabel.text = [self.suggestionOptions objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textField setText:[self.suggestionOptions objectAtIndex:indexPath.row]];
    
    [self loadBySearch:self.textField.text];
    
    [self hideOptionsView];
}

#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    self.textField = textField;
    NSString *curString = textField.text;
    
    if (![curString length])
    {
        [self hideOptionsView];
        return;
    } else
        [GoogleSuggestionReceiver suggest: curString : self];
}

-(void)checkView
{
    if ([self.suggestionsDictionary count]>0)
    {
        self.suggestionOptions = self.suggestionsDictionary;
        [self showOptionsView];
        [self reloadData];
    }else
        [self hideOptionsView];
}

#pragma mark - Options view control
- (void)showOptionsView
{
    self.hidden = NO;
}

- (void) hideOptionsView
{
    self.hidden = YES;
}

@end