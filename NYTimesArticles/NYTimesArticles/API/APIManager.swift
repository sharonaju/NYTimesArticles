//
//  APIManager.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import Alamofire

class APIManager: NSObject {
    
    private let sessionManager: Session
    
    private static var sharedAPIManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        return apiManager
    }()
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<T, ErrorInfo>) -> Void) where T: Codable {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding
        )
        .validate().responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    handler(.success(result))
                } catch {
                    print(error)
                }
            case .failure(let error):
                if let errorInfo = (self.parseApiError(data: response.data, error: error, endPoint: type)) {
                    handler(.failure(errorInfo))
                } else {
                    let errorInfo = ErrorInfo( body: "Something went wrong")
                    handler(.failure(errorInfo))
                }
            }
            
        })
        
    }

    func parseApiError(data: Data? = nil, error: AFError? = nil, endPoint: EndPointType? = nil) -> ErrorInfo? {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorResponse.self, from: jsonData) {
            let errorInfo = ErrorInfo(body: error.message ?? "")
            return errorInfo
        }
        return nil
    }
}

