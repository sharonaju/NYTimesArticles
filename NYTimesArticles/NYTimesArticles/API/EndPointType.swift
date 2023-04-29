//
//  EndPointType.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var version: String { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    
}
