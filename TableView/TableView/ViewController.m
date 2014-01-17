#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableDictionary *nominalCells;
@property (nonatomic, strong) NSMutableArray *cellData;
@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleCell" bundle:nil] forCellReuseIdentifier:@"simple_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"image_cell"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.nominalCells = [NSMutableDictionary dictionaryWithCapacity:2];
    self.cellData = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [self.cellData addObject:@{
                @"identifier" : [@[@"simple_cell", @"image_cell"] objectAtIndex:arc4random_uniform(2)],
                @"label_one" : [self generateString],
                @"label_two" : [self generateString]
        }];
    }
}

- (NSString *)generateString {
    int words = arc4random() % 10 + 1;
    NSMutableArray *strings = [NSMutableArray arrayWithCapacity:words];
    for (int w = 0; w < words; w++) {
        int length = arc4random() % 15 + 1;
        NSMutableString* string = [NSMutableString stringWithCapacity:length];
        for (int i = 0; i < length; i++)
            [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
        [strings addObject:[NSString stringWithFormat:@"^%@$", string]];
    }
    return [NSString stringWithFormat:@"|%@|", [strings componentsJoinedByString:@" "]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.cellData objectAtIndex:(NSUInteger) indexPath.row];
    [[self nominalCellForIdentifier:data[@"identifier"]] bindData:data];
    [[self nominalCellForIdentifier:data[@"identifier"]] setNeedsLayout];
    [[self nominalCellForIdentifier:data[@"identifier"]] layoutIfNeeded];
    CGFloat height = [[self nominalCellForIdentifier:data[@"identifier"]].contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    NSLog(@"height:%f forRow: %i", height, indexPath.row);
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.cellData objectAtIndex:(NSUInteger) indexPath.row];
    TableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:data[@"identifier"]];
    [cell bindData:data];
    return cell;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.nominalCells removeAllObjects];
    [self.tableView reloadData];
}

- (TableCell *)nominalCellForIdentifier:(NSString *)identifier {
    if (!self.nominalCells[identifier])
        self.nominalCells[identifier] = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    return self.nominalCells[identifier];
}

@end

@implementation TableCell
- (void)bindData:(NSDictionary *)data {
    if (self.logoView)
        self.logoView.image = [UIImage imageNamed:@"example.png"];
    self.labelOne.text = data[@"label_one"];
    self.labelTwo.text = data[@"label_two"];

}
@end