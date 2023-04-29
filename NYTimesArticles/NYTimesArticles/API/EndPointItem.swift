//
//  EndPointItem.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import Foundation
import Alamofire

enum EndPointItem {
    case viewed(_: Int)
}

extension EndPointItem: EndPointType{
    
    var baseURL: String {
        return "http://api.nytimes.com/svc/mostpopular/"
    }
    
    var path: String {
        switch self {
        case .viewed(let numberOfDays):
            return "mostviewed/all-sections/\(numberOfDays).json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .viewed:
            return .get
        }
    }
    
    var version: String {
            return "v2/"
    }
    var url: URL {
        return URL(string: self.baseURL + self.version + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

}


