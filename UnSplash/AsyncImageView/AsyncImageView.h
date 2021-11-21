#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define TMP NSTemporaryDirectory()

@interface AsyncImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; 
	CGPoint centerPoint;
	CGRect myFrame;
	CGRect setFrame;
	UIImage * myImagePrevious;
}

@property (nonatomic,assign)    CGSize Size_;
@property (nonatomic,assign)    BOOL IsPerson;

-(void)setImageURL:(NSURL*)url;
-(void)imageFrameChoice;
+(void)RefreshCache;
@end
