
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XHButtonTitlePostionType) {
    XHButtonTitlePostionTypeBottom = 0,
};

@interface UIButton (XHButtonTitlePosition)

- (void)setTitlePositionWithType:(XHButtonTitlePostionType)type;

@end
