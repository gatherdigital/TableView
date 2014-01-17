#import "Label.h"


@implementation Label

- (void)layoutSubviews {
    [super layoutSubviews];
    self.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    [super layoutSubviews];
}

@end