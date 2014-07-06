#import <UIKit/UIKit.h>


@class AutocompletionTableView;


@protocol AutocompletionTableViewDelegate <NSObject>

@required
@end

@interface AutocompletionTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *suggestionsDictionary;
@property (nonatomic, strong) id<AutocompletionTableViewDelegate> autoCompleteDelegate;
@property (nonatomic, strong) NSDictionary *options;

- (AutocompletionTableView *)autoCompleter;

- (UITableView *)initWithTextField:(UITextField *)textField : (UIView *) container: (UIWebView *) webView ;
- (void)checkView;
- (void) hideOptionsView;

@end