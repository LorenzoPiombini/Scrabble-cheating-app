//
//  Network.swift
//  Scrabble Cheating app
//
//  Created by Lorenzo piombini on 3/23/21.
//

import Foundation


class Network: NSObject {
    static let shared = Network()
    let session = URLSession(configuration: .default)
    let url = "https://s3.amazonaws.com/thinkific/file_uploads/88925/attachments/fcd/686/a82/dictionary.txt"
    var dictionary:String?
    var myTrie: Trie?
    func fetchTheWordDictionary(OnSuccess: @escaping ([String?])->Void, OnError: @escaping (String)->Void){
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    OnError("\(error)")
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {OnError("Something went wrong!")
                    return}
                
                
                    if response.statusCode == 200 {
                    
                        
                        
                        self.dictionary =  String(data: data, encoding: .utf8)
                        let array = self.dictionary?.components(separatedBy: .newlines)
                        guard let set = array else {return}
                        
                        OnSuccess(set)
                        return
                    }else {
                        OnError("Status Code \(response.statusCode)")
                    }
                    
                
            }
            
            
            
        }
        task.resume()
        
    }
    
    //do the request to parse the dictionary eith the word and then parse in to a Trie Data structure you have also
    // you will have also to understand how to parse the content of the File.txt 
}
