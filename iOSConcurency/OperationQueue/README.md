# iOS Concurency
## Operation Queues


 1. It's not really queue. 
    Beacuse Operation Queues is not actual FIFO, 
    Example: 
    
    task1 -> task2 -> task3 task4 
    Arrow is the dependencies, so task1 task4 are executed first. After task1 is finished. Task2 begin start.
    
2. Instance of NSOperationQueue => It will have more functionality than the dispatchQueue which base on C function API.

3. Stores the NSOperation objects -> So we can do more with the objects just than blocks/closures

4. Always executed in concurency. 
    _ Note: Operation queue have technich to executed operation objects by interoperation dependencies.


## Operation objects/ NSOperation


 1. Two concrete class which provide by framework. 
    _ NSInvocationOperation: contains selector/func 
    _ NSBlockOpertion: contains blocks/clousure
    
 2. Custome object.
 
 3. Functionality with instance of NSOperation.
    _ KVO: help us to observe the status change of block
        isExecuting                 isReady
        isFinished                  dependencies
        isConcurent                 queuePriority
        isCancelled                 completionBlock
    _ Interopertion dependencies: 
        Can add opertion object depend on the other opertion objects. That mean when object1 is finished. Object2 will be start.
        NOTE: if object1 is cancelled. Object will be start.
    _ Add the queue priority;
        For the queue priority: have enum for each levels (very hight, hight, normal, low)
        For the thread priority: have range of value 0...1( 1 is the hightest priority)
    _ Add the completion block for opertation object. Can use for log or tracking
    _ Cancellation: 
        Cancel for individual task
        Operation Queue can cancel all the tasks.
        NOTE: task in here is the opertion object which are not executed. Cannot cancel the task is executed.
        https://developer.apple.com/documentation/foundation/nsoperation/1411672-cancel


