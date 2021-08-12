import Foundation

enum RequestError: Error {
    case forwarded(Error)
    case wrongStatusCode(Int)
    case unknown
}

public struct Request {
    public static func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { payload, response, error in
            var requestError: RequestError
            guard let data = payload, error == nil else {
                if let localError = error {
                    requestError = .forwarded(localError)
                } else {
                    requestError = .unknown
                }
                completion(.failure(requestError))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                requestError = .wrongStatusCode(httpStatus.statusCode)
                completion(.failure(requestError))
            } else {
                completion(.success(data))
            }
        }.resume()
    }
}
