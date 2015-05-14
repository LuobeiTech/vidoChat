
#import <Foundation/Foundation.h>

// 头像大小以及头像与其他控件的距离
static CGFloat const kXHAvatarImageSize = 40.0f;
static CGFloat const kXHAlbumAvatorSpacing = 15.0f;

typedef NS_ENUM(NSInteger, XHMessageAvatorType) {
    XHMessageAvatorTypeNormal = 0,
    XHMessageAvatorTypeSquare,
    XHMessageAvatorTypeCircle
};

@interface XHMessageAvatorFactory : NSObject

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(XHMessageAvatorType)type;

@end
