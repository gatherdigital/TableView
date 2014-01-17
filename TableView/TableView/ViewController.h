#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@end

@interface TableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *logoView;
@property (nonatomic, weak) IBOutlet UILabel *labelOne;
@property (nonatomic, weak) IBOutlet UILabel *labelTwo;
- (void)bindData:(NSDictionary *)data;
@end
