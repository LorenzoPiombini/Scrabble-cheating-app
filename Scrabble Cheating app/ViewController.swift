//
//  ViewController.swift
//  Scrabble Cheating app
//
//  Created by Lorenzo piombini on 3/22/21.
//

import UIKit

class ViewController: UIViewController {
    var validWords = Set<String>()
    var set = Set<String?>()
    var letters = [String]()
    @IBOutlet weak var lettersLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        letters = letterPicker()
        var index = 0
        for _ in letters{
            lettersLabel.text! += "\(letters[index].uppercased()) "
            index += 1
        }
        
    
       
      
        Network.shared.fetchTheWordDictionary {[self] (dictionary) in
            set = Set(dictionary)
           
           
            
            
        } OnError: { (mannaggia) in
            print("\(mannaggia)")
        }
        
        
        
        
        
        }
        

    @IBAction func restart(_ sender: UIButton){
        resultLabel.text = ""
        lettersLabel.text = ""
        var counter = 0
        var key = 1
        for _ in bag {
            
            if bag[key]!.count == 0 {
                 counter += 1
            }
            key += 1
        }
        if counter >= 22 {
            resultLabel.text = " few letters are left, GAME OVER"
        } else {
            letters = letterPicker()
            var index = 0
            for _ in letters{
                lettersLabel.text! += "\(letters[index].uppercased()) "
                index += 1
            }
        }
        
    }
    
 @IBAction func cheat(_ sender: UIButton){
    var counter = 0
    var key = 1
    for _ in bag {
        
        if bag[key]!.count == 0 {
             counter += 1
        }
        key += 1
    }
    if counter >= 22 {
        resultLabel.text = " few letters are left, GAME OVER"
        lettersLabel.text = "S O R R Y ! :("
    } else {
        let attempt = creatingAllWordWithTheGivenLetters(letters: letters, minStringLenght: 2)
            
            for i in attempt {
                if set.contains(i){
                    
                    resultLabel.text! += "\(i) \(calculatePoints(validWord: i))pt, "
                }
        }
    
    }
        
        
    
    
    if resultLabel.text == "" {
        resultLabel.text = "No words found, hit restart to play it agian!"
    }
 }
    
    func letterPicker()-> [String] {
        var letter = [String]()
        for _ in 0...6 {
            var value = Int.random(in: 1..<27)
            print(value)
            let drawLetter = bag[value]!
            if drawLetter.count > 1 {
                letter.append(String(drawLetter[0].lowercased()))
                bag[value]!.removeLast()
              
            } else if drawLetter.count == 1{
                letter.append(String(drawLetter[0].lowercased()))
                bag[value]!.removeAll()
              
            }else{
                var exit = false
                repeat{
                    
                    switch value {
                    case 27:
                        value -= 1
                    case 1:
                        value += 1
                     

                    default:
                        value += 1
                    }
                    if value == 27 {
                        value -= 1
                    }
                    if !bag[value]!.isEmpty{
                        print(value)
                        let pickedLetter = String(bag[value]![0])
                        if bag[value]!.count > 1 {
                            bag[value]!.removeLast()
                        }else if bag[value]!.count == 1{
                            bag[value]!.removeAll()
                        }
                        letter.append(pickedLetter)
                        exit = true
                    }
                    value = Int.random(in: 1..<27)
                }while( exit == false)
            }
            
    }
        return letter
    }

    
    func creatingAllWordWithTheGivenLetters(letters:[String], minStringLenght: Int)-> Set<String> {
        func permute(fromLetters: [String], toWords: [String], minStringLen: Int, set: inout Set<String>){
            if toWords.count >= minStringLen {
                set.insert(toWords.joined(separator: ""))
            }
            if !fromLetters.isEmpty {
                for (index, item) in fromLetters.enumerated() {
                    var newLetters = fromLetters
                    newLetters.remove(at: index)
                    permute(fromLetters: newLetters, toWords: toWords + [item], minStringLen: minStringLenght, set: &set)
                }
            }
        }
        
        var set = Set<String>()
        permute(fromLetters: letters, toWords: [], minStringLen: minStringLenght, set: &set)
        return set
         
        
    }
    
    
    func calculatePoints(validWord: String) -> Int{
      
        
        var key = 1
        var result = 0
        for char in validWord {
            for _ in 0...6{
                if point[key]!.contains(String(char)){
                      result += key
                    break
                }
                
         
                if key == 5 {
                    key += 3
                } else if key == 8{
                    key += 2
                } else if key < 5 {
                    key += 1
                } else {
                    key = 1
                }
            }
            
        
        }
        
        return result
       
        
        
        
    }
    
}

