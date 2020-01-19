//
//  Request.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

enum RequestType: String {
   case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

class Request {
   
   let action: String // the api endpoint used by the request
   let parameters: [String: String] // parameters used in the url
   let requestType: RequestType // HTTP Method for REST API
   private let body: [String: Any]? // json body of requst
   
   /**
   We need to convert the Dictionary body to Data to be used with URL Session
   */
   var data: Data? {
      if let body = body {
         return try? JSONSerialization.data(withJSONObject: body, options: [])
      }
      return nil
   }

   // MARK: - Initializers
   
   init(action: String, parameters: [String: String], requestType: RequestType, body: [String: Any]? = nil) {
      self.action = action
      self.parameters = parameters
      self.requestType = requestType
      self.body = body
   }
   
}
