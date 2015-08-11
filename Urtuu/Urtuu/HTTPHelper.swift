//
//  HTTPHelper.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

class HTTPHelper {
    
    static let URTU_BASE_URL = ""
    
    func buildRequest(requestType: String, requestItem: String, method: String) -> NSMutableURLRequest {
        var requestURL: NSURL!
        var request: NSMutableURLRequest!
        
        //build request URL
        requestURL = NSURL(string: "\(HTTPHelper.URTU_BASE_URL)")
        request = NSMutableURLRequest(URL: requestURL)
        
        //set request method
        request.HTTPMethod = method
        
        return request
    }
    
    //func sendProductRequest(request: NSURlRequest,
    
    func sendRequest(request: NSURLRequest, completion: (NSData!, NSError!) -> Void) -> () {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(data, error)
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        var jsonerror:NSError?
                        if let errorDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&jsonerror) as? NSDictionary {
                            let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: errorDict as? [NSObject : AnyObject])
                            completion(data, responseError)
                        }
                    }
                }
            })
        }
        //start task
        task.resume()
    }
    
}