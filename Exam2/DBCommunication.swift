//
//  DBCommunication.swift
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

import UIKit

class DBCommunication: NSObject {

    private var session: URLSession!
    var allDataItems: Set<String>! = Set<String>()
    static let instance: DBCommunication = DBCommunication()
    
    override init() {
        let sessionConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }
    
    func login(with username: String, password: String, completionHandler: @escaping (_ success: Bool)->())
    {
        
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/Vitomir/users/\(username).json") else {return}
        //guard let URL = URL(string: "https://my-awesome-project-6b155.firebaseio.com/fabric/users/\(username).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                print(username, password)
                if (statusCode == 200){
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any?]
                        
                        guard let DBUsername = json["username"] as? String else {
                            completionHandler(false)
                            return}
                        guard let DBPass = json["password"] as? String else {
                            completionHandler(false)
                            return}
                        
                        if DBUsername == username && DBPass == password{
                            completionHandler(true)
                            return
                        }
                    }
                    catch {
                    }
                }
                
                completionHandler(false)
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    func sendInfoToDB(info:[String: Any?]) {
        let personUserName = info[UserDefaultKeys.username.rawValue] as! String
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/Vitomir/users/Vitomir/\(personUserName).json") else {return}
        //guard let URL = URL(string: "https://my-awesome-project-6b155.firebaseio.com/fabric/users/fabric\(personUserName).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: info, options: [])
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    func sendInfoCardToDB(info:[String: Any?]) {
        let personUserName = info[DataNames.recepient.rawValue] as! String
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/Vitomir/users/Vitomir/\(personUserName).json") else {return}
        //guard let URL = URL(string: "https://my-awesome-project-6b155.firebaseio.com/fabric/users/fabric\(personUserName).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: info, options: [])
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    func getAllInfo(){
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/Vitomir/users/Vitomir.json?shallow=true") else {return}
        //guard let URL = URL(string: "https://my-awesome-project-6b155.firebaseio.com/fabric/users/fabric.json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                if (statusCode == 200){
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any?]
                        
                        for anItem in json{
                            self.allDataItems.insert(anItem.key)
                        }
                        NotificationCenter.default.post(name: .DataReloaded, object: self)
                        
                    }
                    catch {
                    }
                }
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    func getInfoForItem(itemId: String, completion:@escaping (_ item: [String:Any?]?)->()){
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/Vitomir/users/Vitomir/\(itemId).json") else {return}
        //guard let URL = URL(string: "https://my-awesome-project-6b155.firebaseio.com/fabric/users/fabric/\(itemId).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                if (statusCode == 200){
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any?]
                        completion(json)
                    }
                    catch {
                        completion(nil)
                    }
                }
                else {
                    completion(nil)
                }
            }
            else {
                completion(nil)
            }
        })
        task.resume()
    }
    
}
