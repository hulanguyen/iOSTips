# iOS Concurency
## Dispatch Queue

-  Queue: store block of code
    * asynchoronus: return after it add to the queue.  
    * synchoronus; return after the block is finished.
-  Dispatch Queue types: 
    * Serial queues: execute on task at time
    * Concurrent queues: execute multiple tasks at time.
-  Execute on other threads
-  Main Queue is a serial queue, and execute on main thread.

## Visualize : 
    
    Serial queue: 
    .....
    task5
    task4
    task3
    task2
    task1 
* Spawn background thread and this thread executed the task serially.
    ThreadA : task1 (done) -> ThreadA: task2 (done) -> ....
* task1 is executed, after it's finished, then task2 is excecuted....
* Used to serialize access to a shared source
* Definitive execution order.


    Concurent queue: 
    .....
    task5
    task4
    task3
    task2
    task1 

Spawn multiple background threads to excute tasks.
ThreadA         ThreadB     ThreadC
task1           task2       task3

If task2 is finished, then task4 is assinged for testing.

ThreadA         ThreadB     ThreadC
task1           task4       task3 

How many threads can spawns in here. It's depend on the OS. But if it have to much threads -> we got the threads explosion. 
#Key take away in here that's tasks in cuncurrent queue are executed sequently and started right after the previous task started/handle by bg thread.


You can look at the sample and the instructions files for the simulation of problem block main thread and solutions for this.
 
