#import "AsyncImageView.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"

#define SPINNY_TAG 5555   

@implementation AsyncImageView

@synthesize Size_;

static ImageCache *imageCache = nil;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
	self.backgroundColor = [UIColor clearColor];
	myFrame = frame;
    self.IsPerson = NO;
    return self;
}
- (void)drawRect:(CGRect)rect 
{
    // Drawing code
}
- (void)dealloc 
{
    [connection cancel];
    [connection release];
    [data release];
	//[imageCache release];
    [super dealloc];
}
+(void)RefreshCache
{
    [imageCache RemoveCache];

}
-(void)setImageURL:(NSURL*)url 
{
	if (connection != nil)
    {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil)
    {
        [data release];
        data = nil;
    }
    
	if (imageCache == nil) // lazily create image cache
		imageCache = [[ImageCache alloc] initWithMaxSize:2];  // 2 MB Image cache
    [urlString release];
    urlString = [[url absoluteString] copy];
	UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) 
    {
        Size_ = cachedImage.size;

        while ([[self subviews] count] > 0)
        {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        
        if (self.tag==1478) {
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
        else{ imageView.contentMode = UIViewContentModeScaleAspectFill;
            
        }
        
        imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.tag = 5002;
        [self addSubview:imageView];
		centerPoint=imageView.center;
        imageView.frame = self.bounds;
        [imageView setNeedsLayout];
        [self setNeedsLayout];
        return;
	} 
	else 
    {
		while ([[self subviews] count] > 0)
        {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
	}
    
    
    if([urlString isEqualToString:@"https://www.google.com"] != YES && urlString != nil)
    {
        [self imageFrameChoice];
    }
    
	NSURLRequest *request = [NSURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestUseProtocolCachePolicy 
                            timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
-(void)loadImageFromURL:(NSURL*)url ForImageView:(UIImageView *)FinalImageView
{
	if (connection != nil) 
    {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil)
    {
        [data release];
        data = nil;
    }
	if (imageCache == nil) // lazily create image cache
		imageCache = [[ImageCache alloc] initWithMaxSize:2];  // 2 MB Image cache
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    
	UIImage *cachedImage = [imageCache imageForKey:urlString];
    
    if (cachedImage != nil) 
    {
        while ([[self subviews] count] > 0)
        {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.tag = 5002;
        [self addSubview:imageView];
		centerPoint=imageView.center;
        imageView.frame = self.bounds;
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
	} 
	else 
    {
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage
																	  imageNamed:@"placeholder.png"]] autorelease];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
        centerPoint=imageView.center;
		imageView.autoresizingMask =
		UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.tag = 5002;
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout];
		[self setNeedsLayout];
	}    
	[self imageFrameChoice];	
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData
{
    if (data==nil)
    {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    [connection release];
    connection = nil;
    UIView *spinny = [self viewWithTag:SPINNY_TAG];
    [spinny removeFromSuperview];
    if ([[self subviews] count] > 0)
	{
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    UIImage *image = [UIImage imageWithData:data];
    Size_ = image.size;
	//UIImage * newImage =  [self imageByScalingProportionallyToSize:myFrame.size];
    UIImageView *imageView = [[[UIImageView alloc] 
                               initWithImage:image] autorelease];
    if (self.tag==1478) {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    else{ imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    imageView.tag = 5002;
	[self addSubview:imageView];
	[imageCache insertImage:image withSize:1 forKey:urlString];
	imageView.frame = self.bounds;
	[self setNeedsLayout];
    [data release];
    data = nil;
}
-(void)imageFrameChoice
{
    
	UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.color = [UIColor colorWithRed:192.0/255.0 green:135.0/255.0 blue:0.0 alpha:1.0];

    spinny.tag = SPINNY_TAG;
    centerPoint = CGPointMake(self.frame.size.width/2.0,self.frame.size.height/2.0);
    spinny.center = centerPoint;
    [spinny startAnimating];
    [self addSubview:spinny];
    [spinny release];	
}

@end
