//
//  APISession.swift
//  CurrencyConverter
//
//  Created by James Coughlan on 17/01/2020.
//  Copyright © 2020 James Coughlan. All rights reserved.
//

import Foundation

typealias ServiceResponse = (Any?, String?) -> Void

class APISession {
   
   private let session: URLSession
   private let networkSettings: NetworkSettings
   private let request: Request
   
   private var url: URL? {
      let path = "\(networkSettings.baseURL)\(request.action)?access_key=\(networkSettings.accessKey)&\(request.parameters.map({ "\($0.key)=\($0.value)" }).joined(separator: "&"))"
      return URL(string: path)
   }
   
   // MARK: - Initializers
   
   
   init(session: URLSession = URLSession.shared, request: Request, networkSettings: NetworkSettings) {
      self.session = session
      self.request = request
      self.networkSettings = networkSettings
   }
   
   // MARK: - Public
   
   /**
    Execute the API request
    - parameters:
      -  onCompletion: returns a ServiceResponse type containing either the model or the error message
    */
   func execute(_ onCompletion: @escaping ServiceResponse) {
      if let url = url { //todo throw error if url fails
         var urlRequest = URLRequest(url: url)
         
         urlRequest.httpMethod = request.requestType.rawValue
         
         let responseHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            DispatchQueue.main.async {
               if error != nil || data == nil {
                  onCompletion(nil, "Client error!")
                  return
               }
               
               guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                  onCompletion(nil, "Server error!")
                  return
               }
               do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: [])
                  onCompletion(json, nil)
               } catch {
                  onCompletion(nil, "JSON error: \(error.localizedDescription)")
               }
            }
         }
         
         if let data = request.data {
            let task = session.uploadTask(with: urlRequest, from: data, completionHandler: responseHandler)
            task.resume()
         } else {
            let task = session.dataTask(with: urlRequest, completionHandler: responseHandler)
            task.resume()
         }
         
      }
   }
}
