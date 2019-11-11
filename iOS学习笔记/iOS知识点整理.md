1、讲讲你对`atomic` & `nonatomic`的理解

atomic 原子性 不意味着线程绝对安全 能增加正确的几率 保证多线程访问 同一时间只有一个线程对对象进行操作（setter or getter 不包括同时读取）

setter 伪代码

```
- (void)settAge:(Int)age{
	 lock
	 _age = age;
	 unlock;
}
```



nonatomic 非原子性



假设有一个atomic 的属性”name”，如果线程A调用`[self setName:@"A"]`，线程B 调用`[self setName:@"B"]`， 线程 C调用`[self name]`，那么所有这些不同线程上的操作都将一次顺序执行，也就是说，如果一个线程正在执行getter/setter，其他线程就得等待。因此，属性 name 是读写安全的。

但是，如果有另一个线程D 同时再调`[name release]`，那可能就会crash，因为release 不受getter/setter 操作的限制。也就是说，这个属性只能说是读/写安全的，但并不是线程安全的，因为别的线程还能进行读写之外的其他操作。线程安全需要开发者自己来保证。

如果name 是 nonatomic的，那么上面的李自力的所有线程A、B、C、D 都可以同时执行，可能导致无法预料的结果。如果是atomic 的，那么 A、B、C会串行，而D还是会并发执行。



2、weak实现原理 sideTable

```
xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-8.0.0 main.m
```

编译main.m



sidetable {

​	spinlock_lock

​	weak_table_t 

​	referencecount

}



3.`block` 用什么修饰？`strong` 可以？

copy修饰   strong修饰

