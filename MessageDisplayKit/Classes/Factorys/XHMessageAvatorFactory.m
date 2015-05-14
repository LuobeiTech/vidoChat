

#import "XHMessageAvatorFactory.h"
#import "UIImage+XHRounded.h"

@implementation XHMessageAvatorFactory

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(XHMessageAvatorType)messageAvatorType {
    CGFloat radius = 0.0;
    switch (messageAvatorType) {
        case XHMessageAvatorTypeNormal:
            return originImage;
            break;
        case XHMessageAvatorTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case XHMessageAvatorTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avator = [originImage createRoundedWithRadius:radius];
    return avator;
}

@end
