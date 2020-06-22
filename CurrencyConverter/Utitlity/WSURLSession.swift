//
//  WSUrlSession.swift
//  Airjobs
//
//  Created by VJ's iMAC on 30/11/18.
//  Copyright © 2017 Manikandan. All rights reserved.
//

import UIKit

let GET     = "GET"
let POST    = "POST"
let PUT     = "PUT"

class WSURLSession: NSObject {

    class var sharedInstance: WSURLSession {
        struct Static {
            static let instance: WSURLSession! = WSURLSession()
        }
        return Static.instance
    }
    
    func apiGetServiceWithURL(url : String, isLoader : (Bool), isLoaderHide : (Bool), response : @escaping (_ responseObj : AnyObject) -> Void, error : @escaping (_ error : String) -> Void)
    {
        if !isConnectedToNetwork()
        {
            return
        }
        
        if isLoader == true
        {
//                showHUDAddedTo()
        }
        
        var requestURL = url
        requestURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        print("REQUEST URL", requestURL)
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: url) as URL?
        request.httpMethod = GET
        request.timeoutInterval = 60
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, responses, errors in
            
            DispatchQueue.main.async {
                () -> Void in
                
                if(errors != nil)
                {
//                   hideHUDForView()

                    print("ERROR = ", errors?.localizedDescription ?? "")
                    error((errors?.localizedDescription)!)
                    return
                }
                
                if let data = data
                {
//                   hideHUDForView()

                    let responseString = String(data: data, encoding: .utf8)!
                    print("RESPONSES = ",responseString)
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    {
                        print("RESPONSE JSON = ", json )
                        response(json as AnyObject)
                    }
                    else
                    {
                        print(LSString("SOMETHING_WRONG"))
                        error(LSString("SOMETHING_WRONG"))
                    }
                }
                else
                {
//                   hideHUDForView()

                    print(LSString("SOMETHING_WRONG"))
                    error(LSString("SOMETHING_WRONG"))
                }
            }
        }
        task.resume()
    }

    
  
}
func LSString(_ key: String) -> String
{
    return NSLocalizedString(key, comment: "")
}
func isConnectedToNetwork() -> Bool
{
    let status = Reach().connectionStatus()
    switch status
    {
    case .unknown, .offline:
        return false
    case .online(.wwan):
        return true
    case .online(.wiFi):
        return true
    }
}
