# Data races condition in swift.
## 1. What is data races condition for swift? 

Two threads access or manipulate the same data at the same time. It will make unexpected behavior:
- Data corruption
- Unexpected result.

Let see why it have this behavior? 
For memory management, we have STACK and HEAP. 
STACK: store local data and function call. Each threads have each own stack.
HEAP: store the objects (instances) or we can say it have dynamic size. Threads share the head memory.

---------------------------------------
|                                      |
|              Heap                    |
|                                      |
---------------------------------------
|           |            |             |
|   Stack   |    Stack   |  Stack      |
| Thread1   |   Thread2  |  ....       |
|           |            |             |
|           |            |             |
|___________|____________|_____________|


Because of threads use the shared data in heap so this is the root cause of these issues we have mentions above. 

## 2. Which technique use to handle the Data race condition ? 

Here is the sample code which lead to the issues: 
class Counter {
    var value = 0
    
    func increment() -> Int {
        value = value + 1
        return value
    }
}

let counter = Counter()

DispatchQueue.global(qos: .background).async {
    print(counter.increment())
}
DispatchQueue.global(qos: .background).async {
    print(counter.increment())
}
The result maybe: 
            1
            1
            or 
            2
            2
###1. Use NSThread: 

###2. Use DispatchSemaphore

For using NSThead and Semaphore, we have to be careful when use it because it might lead to deadlock. First thread is waiting for second thread release resource but this thread is also waiting resource release by first thread.

###3. Use Serial dispatch Queue.


###4. Actor in swift 5.5
Actor is a new type in swift:
- It is a referce type
- It have to due with Data race condition
- It also have clean code (await/async)
Unlike classes, actors allow only one task to access their mutable state at a same time, which make it safe code for multiple task interact with the same instance of actor.

Please take look the code in the Playground for implementation detail for those solution.
Xcode 13.0 beta
Note: Ifactor awai/async is not able run to playground, you can create single project passing those code and running for see the result.
