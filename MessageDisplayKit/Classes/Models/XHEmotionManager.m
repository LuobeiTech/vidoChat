

#import "XHEmotionManager.h"

@implementation XHEmotionManager

- (void)dealloc {
    [self.emotions removeAllObjects];
    self.emotions = nil;
}

@end
