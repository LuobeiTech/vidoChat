

#import <UIKit/UIKit.h>

typedef enum {
    DeleteButtonStyleDelete,
    DeleteButtonStyleNormal,
    DeleteButtonStyleDisable,
}DeleteButtonStyle;

@interface DeleteButton : UIButton

@property (assign, nonatomic) DeleteButtonStyle style;

- (void)setButtonStyle:(DeleteButtonStyle)style;
+ (DeleteButton *)getInstance;

@end
