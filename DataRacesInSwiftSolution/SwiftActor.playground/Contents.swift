import UIKit
import PlaygroundSupport
//Common issue
// Data race condition
// Two thread is access to the same data source in the same time. It get the data corruption or unexpected result

//Sample one and the old approved

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

// Solution with locks by using semaphore
//

//###1. Use NSThread:
let lockObj = NSLock()

asyncDetached(priority: .userInitiated) {
    lockObj.lock()
}

asyncDetached(priority: .background) {

    print("First Increment: \(counter.increment())")
    lockObj.unlock()
}
lockObj.lock()
asyncDetached(priority: .background) {

    print("Second Increment: \(counter.increment())")
    lockObj.unlock()
}

//###2. Use semaphore
let semaphore = DispatchSemaphore(value: 0)

DispatchQueue.global(qos: .background).async {
    semaphore.wait()
    print("First Thread:\(counter.increment())")
    semaphore.signal()
}

DispatchQueue.global(qos: .background).async {
    semaphore.wait()
    print("Second Thread:\(counter.increment())")
    semaphore.signal()
}
semaphore.signal()

////###3. Use Serial Queue


let serialQueue = DispatchQueue(label: "swift.actor.serial.queue")


asyncDetached(priority: .background) {
    serialQueue.sync {
        print("First Thread:\(counter.increment())")
    }
}

asyncDetached(priority: .background) {
    serialQueue.sync {
        print("Second Thread:\(counter.increment())")
    }
}
// When run this code, some time it print
// Second Thread:1
// First Thread:2
// Some time it print
//First Thread:1
//Second Thread:2


asyncDetached(priority: .background) {
    serialQueue.async {
        print("First Thread:\(counter.increment())")
    }
}

asyncDetached(priority: .background) {
    serialQueue.async {
        print("Second Thread:\(counter.increment())")
    }
}

/////4. actor
//for Swift 5.5
// we can use actor for doing this.
// actor is reference type.
//
actor Counter1 {
    var value = 0

    func increment() -> Int {
        value = value + 1
        return value
    }
}

let counter1 = Counter1()
asyncDetached(priority: .background) {
    print("First increment \(await counter1.increment())")
}

asyncDetached(priority: .background) {
    print("Second increment \(await counter1.increment())")
}
PlaygroundPage.current.needsIndefiniteExecution = true
