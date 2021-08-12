    import XCTest
    @testable import Request

    final class RequestTests: XCTestCase {
      
        func testRequest() throws {
            
            guard let url = URL(string: "https://apple.com") else {
                XCTAssertThrowsError("Cannot create url link")
                return
            }
            
            let expectation = XCTestExpectation(description: "Downlead from https://apple.com ")
            
            Request.download(from: url) { result in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure:
                    XCTFail("Failed to load value")
                }
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10.0)
        }
        
        func testRequestSemaphore() throws {
            
            guard let url = URL(string: "https://apple.com") else {
                XCTAssertThrowsError("Cannot create url link")
                return
            }
            
            let semaphore = DispatchSemaphore(value: 0)
            
            Request.download(from: url) { result in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure:
                    XCTFail("Failed to load value")
                }
                semaphore.signal()
            }
            
            if semaphore.wait(timeout: .now() + 5) == .timedOut {
                XCTFail("The time out is reach.")
            }
        }
        
        func testAsyncCalls() throws {
            let expectation1 = XCTestExpectation(description: "Task 1 should complete successfully")
            let expectation2 = XCTestExpectation(description: "Task 2 should complete successfully")
            
            DispatchQueue.global(qos: .background).async {
                sleep(2)
                expectation1.fulfill()
            }
            
            DispatchQueue.global(qos: .background).async {
                sleep(2)
                
                expectation2.fulfill()
            }
            
            let result = XCTWaiter.wait(for: [expectation1, expectation2], timeout: 15, enforceOrder: true)
            
            switch result {
            case .completed:
                print("Success")
            case .timedOut:
                XCTFail("Time out error")
            case .incorrectOrder:
                print("\n Incorret order, but that's totally fine. \n")
            default:
                XCTFail("Something went wrong")
            }
        }
        
        func testAsyncCallsWithSemaphore() throws {
           let semaphore = DispatchSemaphore(value: 1)
            
            DispatchQueue.global(qos: .background).async {
                sleep(2)
                semaphore.signal()
            }
            if semaphore.wait(timeout: .now() + 3) == .timedOut {
                XCTFail("Time out is reach")
            }
            DispatchQueue.global(qos: .background).async {
                sleep(2)
                
                semaphore.signal()
            }
            if semaphore.wait(timeout: .now() + 3) == .timedOut {
                XCTFail("Time out is reach")
            }
            
            print("Test is success full ")
        }
    }
