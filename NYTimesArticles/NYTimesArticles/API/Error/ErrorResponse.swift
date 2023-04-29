//
//  ErrorResponse.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//

import UIKit

class ErrorResponse: Codable {
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "error"
    }
}

