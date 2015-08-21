//
//  HTTPHelper.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/20/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import Foundation

struct HTTPHelper {
    
    static let URTU_BASE_URL = "https://niupiaomarket.herokuapp.com/mobile"
    
    func buildLoginRequest(email: String, fbId: String) -> NSMutableURLRequest {
        var requestURL: NSURL!
        var request: NSMutableURLRequest!
        
        //build request URL
        requestURL = NSURL(string: "\(HTTPHelper.URTU_BASE_URL)/login?email=\(email)&facebook_id=\(fbId)")
        request = NSMutableURLRequest(URL: requestURL)
        
        //set request method
        request.HTTPMethod = "GET"
        
        return request
    }
    
    func buildSignUpRequest(email: String, fName: String, lName: String, fbId: String) -> NSMutableURLRequest {
        var signUpURL: NSURL!
        var signUpRequest: NSMutableURLRequest!
        
        //build signup URL
        signUpURL = NSURL(string: "\(HTTPHelper.URTU_BASE_URL)/register?email=\(email)&first_name=\(fName)&last_name=\(lName)&facebook_id=\(fbId)")
        signUpRequest = NSMutableURLRequest(URL: signUpURL)
        
        //set method
        signUpRequest.HTTPMethod = "GET"
        
        return signUpRequest
    }
    
    func buildOrderHistoryRequest(email: String, fbId: String) -> NSMutableURLRequest {
        var orderHistoryURL: NSURL!
        var orderHistoryRequest: NSMutableURLRequest!
        
        // order history endpoint
        orderHistoryURL = NSURL(string: "\(HTTPHelper.URTU_BASE_URL)/purchasereceipts?email=\(email)&facebook_id=\(fbId)")
        orderHistoryRequest = NSMutableURLRequest(URL: orderHistoryURL)
        
        // request method
        orderHistoryRequest.HTTPMethod = "GET"
        
        return orderHistoryRequest
    }
    
    func buildItemsRequest(email: String, fbId: String, pageSize: String, pageNumber: String) -> NSMutableURLRequest {
        var itemsRequestURL: NSURL!
        var itemsRequest: NSMutableURLRequest!
        
        itemsRequestURL = NSURL(string: "\(HTTPHelper.URTU_BASE_URL)/items?email=\(email)&facebook_id=\(fbId)&page_size=\(pageSize)&page=\(pageNumber)&order=id&direction=ASC")!
        itemsRequest = NSMutableURLRequest(URL: itemsRequestURL)
        
        itemsRequest.HTTPMethod = "GET"
        
        return itemsRequest
    }
    
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
    
    func parseItemsJsonArray(object: AnyObject, category: String) -> Array<Item> {
        var itemsList: Array<Item> = []
        
        if object is Array<AnyObject> {
            for json in object as! Array<AnyObject> {
                var item: Item = Item()
                item.id = (json["id"] as AnyObject? as? Int) ?? 0
                item.name = (json["name"] as AnyObject? as? String) ?? ""
                item.price = (json["price"] as AnyObject? as? Double) ?? 0.0
                item.quantity = (json["quantity"] as AnyObject? as? Int) ?? 0
                itemsList.append(item)
            }
        }
        return itemsList
    }
    
}