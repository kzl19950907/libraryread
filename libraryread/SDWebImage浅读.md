[TOC]


* ### UIImageView+WebCache  

给imageView设置图片    
```
[bImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];   
```
接下来调用到方法,我们一步一步分析每行代码分别做了什么操作。
```
-(void)sd_internalSetImageWithURL:(nullable NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholder
                           options:(SDWebImageOptions)options
                      operationKey:(nullable NSString *)operationKey
                     setImageBlock:(nullable SDSetImageBlock)setImageBlock
                          progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                         completed:(nullable SDExternalCompletionBlock)completedBlock
                           context:(nullable NSDictionary<NSString *, id> *)context
```
- ##### validOperationKey
validOperationKey代表的是存放UIView中所有optration的key,如果没有就以当前类class作为key。
```
NSString *validOperationKey = operationKey?:NSStringFromClass([self class]);    
```   
- #### sd_cancelImageLoadOperationWithKey
调用cancle方法,通过key取消当前所有的图片加载操作。首先获取view中的oprationDictionary,找到当前key对应的operation 并调用cancle,从 oprationDictionary移除当前操作key。   

  ```
  [self sd_cancelImageLoadOperationWithKey:validOperationKey];

  - (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key {
      // Cancel in progress downloader from queue
      SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
      id<SDWebImageOperation> operation;
      @synchronized (self) {
          operation = [operationDictionary objectForKey:key];
      }
      if (operation) {
          if ([operation conformsToProtocol:@protocol(SDWebImageOperation)]){
              [operation cancel];
          }
          @synchronized (self) {
              [operationDictionary removeObjectForKey:key];
          }
      }
  }
  ```

* #### SDOperationsDictionary介绍(UIView+WebCacheOperation)
```
  typedef NSMapTable<NSString *, id<SDWebImageOperation>> SDOperationsDictionary;
```
  从定义来看 SDoperationDictionary是一个NSMaptable泛型,类似于而NSMaptable是什么一个类呢？
- ###### [NSMapTable](http://www.isaced.com/post-235.html)
  NSMapTable 是一个map集合 即可以处理 key->obj映射,也可以处理 obj->obj映射。(NSDictionary只提供了key->obj映射,本质上来讲obj的位置是有key来索引的,并且NSDictionary会复制key到自己的私有空间,key需要遵从NSCopying协议,key应该是小且高效的，以至于复制的时候不会对 CPU 和内存造成负担。)
```
 //key copy  value strong 构造的NSMapTable对象和NSMutableDictionary用起来类似 复制key 并且强引用obj
NSMapTable *keyToObjectMapping = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableStrongMemory];
```   
- ##### sd_operationDictionary
再回来看SDOperationsDictionary的get方法,为UIView动态添加属性sd_operationDictionary     
```
  -(SDOperationsDictionary *)sd_operationDictionary{
        @synchronized(self) {
        SDOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
        if (operations) {
            return operations;
        }
        //key strong obj weak
        operations = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return operations;
      }
  }
```   


接下来继续回到主方法中,为UIView类添加一个一个属性 存放设置图片的url
```
objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
```



options & SDWebImageDelayPlaceholder 这是一个位运算操作 按位与 只有当options为SDWebImageDelayPlaceholder时候才会返回true。   
dispatch_main_async_safe 是保证在主线程中操作UI, 我们先看一下sd_setImage:basedOnClassOrViaCustomSetImageBlock方法中做了些什么
```
if (!(options & SDWebImageDelayPlaceholder)) {       
       if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
           dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
           dispatch_group_enter(group);
       }
       //设置placeholder图片 线程安全
       dispatch_main_async_safe(^{
           [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
       });
   }
```   
- ##### sd_setImage:basedOnClassOrViaCustomSetImageBlock
先判断是否传进来设置图片的回调finalSetImageBlock ,如果有值则不进行处理,让用户自行处理。为空的时候判断view class 分别做不同处理回调。 transition参数控制是否动画设置传进来的placehoderImage, SDWebImageTransition实质就是使用CATransiton类做动画效果,后续会介绍到,此处先行略过...
```
UIView *view = self;
  SDSetImageBlock finalSetImageBlock;
  //用户如果自行处理图片的话setImageBlock不为nil else 生成block
  if (setImageBlock) {
      finalSetImageBlock = setImageBlock;
  }
#if SD_UIKIT || SD_MAC
  else if ([view isKindOfClass:[UIImageView class]]) {
      UIImageView *imageView = (UIImageView *)view;
      finalSetImageBlock = ^(UIImage *setImage, NSData *setImageData) {
          imageView.image = setImage;
      };
  }
#endif
#if SD_UIKIT
  else if ([view isKindOfClass:[UIButton class]]) {
      UIButton *button = (UIButton *)view;
      finalSetImageBlock = ^(UIImage *setImage, NSData *setImageData){
          [button setImage:setImage forState:UIControlStateNormal];
      };
  }
  if (transition) {
  #if SD_UIKIT
          [UIView transitionWithView:view duration:0 options:0 animations:^{
              // 0 duration to let UIKit render placeholder and prepares block
              if (transition.prepares) {
                  transition.prepares(view, image, imageData, cacheType, imageURL);
              }
          } completion:^(BOOL finished) {
              [UIView transitionWithView:view duration:transition.duration options:transition.animationOptions animations:^{
                  if (finalSetImageBlock && !transition.avoidAutoSetImage) {
                      finalSetImageBlock(image, imageData);
                  }
                  if (transition.animations) {
                      transition.animations(view, image);
                  }
              } completion:transition.completion];
          }];
  #endif
  } else {
      if (finalSetImageBlock) {
          finalSetImageBlock(image, imageData);
      }
  }
```

继续往下看代码, 先判断了一下传入的url,如果有正常处理,没有返回error。我们先看一下url正常的流程。首先判断了一下ActivityIndicatorView,然后把当前的图片下载进度重置。接着重头戏就来了,使用SDWebImageManager去下载图片。   

* ### SDWebImageManager

- #### loadImageWithURL:options:progress:completed:
  先看这个方法,首先判断了url的class,外部调用的时候很多人会直接传入NSString的网址过来,这里做了类型判断和转换。接下来判断self.failedURLs中是否包含这个url。如果加载图片方式不为SDWebImageRetryFailed 直接调用完成block 并返回空的operation。
  ```   

  - (id <SDWebImageOperation>)loadImageWithURL:(nullable NSURL *)url
                                     options:(SDWebImageOptions)options
                                    progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                                   completed:(nullable SDInternalCompletionBlock)completedBlock {
    // Invoking this method without a completedBlock is pointless
    NSAssert(completedBlock != nil, @"If you mean to prefetch the image, use -[SDWebImagePrefetcher prefetchURLs] instead");
    // Very common mistake is to send the URL using NSString object instead of NSURL. For some strange reason, Xcode won't
    // throw any warning for this type mismatch. Here we failsafe this error by allowing URLs to be passed as NSString.
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    // Prevents app crashing on argument type error like sending NSNull instead of NSURL
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }

    SDWebImageCombinedOperation *operation = [SDWebImageCombinedOperation new];
    operation.manager = self;
    //如果本身记录过failedURLs 判断是否在其中 标志位置1
    BOOL isFailedUrl = NO;
    if (url) {
        @synchronized (self.failedURLs) {
            isFailedUrl = [self.failedURLs containsObject:url];
        }
    }

    //url为空  （options 不为 retryfailed  并且 failedURLs不包含url） 直接return错误
    if (url.absoluteString.length == 0 || (!(options & SDWebImageRetryFailed) && isFailedUrl)) {
        [self callCompletionBlockForOperation:operation completion:completedBlock error:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil] url:url];
        return operation;
    }
  // 记录到正在运行的runningOperations中
    @synchronized (self.runningOperations) {
           [self.runningOperations addObject:operation];
       }
  ```

- ##### cacheKeyForURL
  通过了之前的url验证之后，通过url找到缓存的cachekey,这里用到了一个属性cacheKeyFielter,我们来看一下定义 SDWebImageCacheKeyFilterBlock cacheKeyFilter ,SDWebImageCacheKeyFilterBlock定义是 typedef NSString * (^SDWebImageCacheKeyFilterBlock)(NSURL \**url); 是一个block 传入参数为url 返回一个NSString的key。而

  ```

  NSString *key = [self cacheKeyForURL:url];

  - (nullable NSString *)cacheKeyForURL:(nullable NSURL *)url {
    if (!url) {
        return @"";
    }

    if (self.cacheKeyFilter) {
        return self.cacheKeyFilter(url);
    } else {
        return url.absoluteString;
    }
  }
  ```












* ####  随笔
  - ##### SDWebImageManager类作用
    init方法中 初始化SDImageCache对象  和SDWebImageDownloader对象 和 一个runningOperations的数组记录正在执行的operation

  - ##### 加载图片过程
    1.先对url做class 判定防止传入类型错误。
    2.生成一个SDWebImageCombinedOperation对象。
    3.判断url是否在failURLs中 (加载方式为SDWebImageRetryFailed无视是否在failURLs中)。
    4.在当前的runningOperations中添加刚才生成的operation对象,记录下来。
    查找url对应的cachekey 通过key去查找缓存图片
    5.如果没有找到或者是其他的加载方式(options不为SDWebImageFromCacheOnly && (cahce中找不到缓存图片|| options为SDWebImageRefreshCached))  就去调用imageDownloader 去down图片
    6.图片下载完成之后判断是否需要缓存,缓存调用SDImageCache对象   




Tip:源码中用了大量的 @synchronized 同步锁保证数据的存取   

dispatch_semaphore_t 信号量

SDWebImage同时下载最大默认数量为6 下载超时时间设置15s























源码阅读计划安排: SDWebImage YYCache YYImage AFNetWorking
个人工具库封装: ADAsyncCacher
Swift: MVVM Rx Moya Almofire Kingfisher






















SD:
