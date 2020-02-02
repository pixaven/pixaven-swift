//
//  FetchRequest.swift
//  Pixaven
//
//  Created by Dawid Płatek on 18/11/2019.
//  Copyright © 2019 Pixaven. All rights reserved.
//

import Foundation

class FetchRequest: BaseRequest {
    var key: String
    var type: RequestType
    var parameters: [String : Any] = [:]
    var isBinary: Bool = false
    let url: URL
    
    var contentType: String {
        return "application/json"
    }

    init(key: String, url: URL) {
        self.type = RequestType.fetch
        self.key = key
        self.url = url
    }
    
    func data() throws -> Data {
        parameters["url"] = url.absoluteString
        
        if isBinary {
            parameters["response"] = ["mode": "binary"]
        }
        
        return try JSONSerialization.data(withJSONObject: parameters, options: [])
    }
}
