
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCacheObject : NSObject {
    NSUInteger size;    // size in bytes of image data
    NSDate *timeStamp;  // time of last access
    UIImage *image;     // cached image
}

@property (nonatomic, readonly) NSUInteger size;
@property (nonatomic, retain, readonly) NSDate *timeStamp;
@property (nonatomic, retain, readonly) UIImage *image;

-(id)initWithSize:(NSUInteger)sz Image:(UIImage*)anImage;
-(void)resetTimeStamp;

@end
