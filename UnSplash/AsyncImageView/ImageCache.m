
#import "ImageCache.h"
#import "ImageCacheObject.h"

@implementation ImageCache

@synthesize totalSize;

-(id)initWithMaxSize:(NSUInteger) max  {
    if (self = [super init]) {
        totalSize = 0;
        maxSize = max;
        myDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)dealloc {
    [myDictionary release];
    [super dealloc];
}

-(void)insertImage:(UIImage*)image withSize:(NSUInteger)sz forKey:(NSString*)key{
    ImageCacheObject *object = [[ImageCacheObject alloc] initWithSize:sz Image:image];
   if (totalSize>maxSize)
	while (totalSize + sz > maxSize-10)
    {
		//NSLog(@"FFFFFFFFFFFFFFFFUUUUUUUUUULLLLLLLLLLLLLL!!!!!!!!!!!!!!!!!!!!!!!!!!");
		NSArray *arr=[myDictionary allKeys];
		NSDate *date=[NSDate date];
		ImageCacheObject *obj;
		NSString *keys1;
		NSString *keys;
		for (int a=0; a<[arr count]; a++) {
			keys=[arr objectAtIndex:a];
			ImageCacheObject *obj1;
			obj1=[myDictionary objectForKey:keys];
			if([obj1.timeStamp compare:date]== NSOrderedAscending)
			{
				date=obj1.timeStamp;
				obj=obj1;
				keys1=[arr objectAtIndex:a];
			}
			
		}
		[myDictionary removeObjectForKey:keys1];
		totalSize -=1;
		
		
       /* totalSize = 0;
        [myDictionary removeAllObjects];*/
    }
    [myDictionary setObject:object forKey:key];
	totalSize += object.size;
    [object release];
}

-(UIImage*)imageForKey:(NSString*)key {
    ImageCacheObject *object = [myDictionary objectForKey:key];
    if (object == nil)
        return nil;
    [object resetTimeStamp];
    return object.image;
}
-(void)RemoveCache
{
    [myDictionary removeAllObjects];


}

@end
