//
//  ErrorInfo.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import Foundation
import Alamofire

struct ErrorInfo: Error {
    let code: Int?
    let responseCode: String?
    var title: String?
    var body: String?
    
    init(code: Int? = nil, responseCode: String? = nil, title: String? = nil, body: String? = nil) {
        self.code = code
        self.responseCode = responseCode
        self.title = title
        self.body = body
    }
}

