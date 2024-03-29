//
//  MemorablePasswordFactory.swift
//  PasswordGenerator
//
//  Created by Rachel Harvey on 10/19/15.
//  Copyright © 2015 Rachel Harvey, Lucas Smith, Aaron Young, and Jeffery Greer. All rights reserved.
//

import Foundation

class MemorablePasswordFactory: NSObject {
    
    private var password:String = ""
    private var passwordLength:Int! = nil
    private var wordGenerator:WordSupplier! = nil
    
    init(length: Int, wordGenerator:WordSupplier) {
        self.passwordLength = length
        self.wordGenerator = wordGenerator
    }
    
    func getRandomWords() -> String! {
        var currentLetterCount = 0
        while(currentLetterCount < passwordLength){
            let maxLength = self.passwordLength - currentLetterCount
            let word = getWordWithoutSpacesOrHypens(maxLength, minLength: 1)
            currentLetterCount += getStringLength(word)
            self.password = self.password + word
        }
        return self.password
    }
    
    private func getLengthOfWordByDifferingLength(word:String) -> Int {
        return self.passwordLength - getStringLength(word)
    }
    
    private func getStringLength(string : String) -> Int {
        return string.characters.count
    }

    private func getWordWithoutSpacesOrHypens(maxLength:Int,minLength:Int) -> String {
        var string = wordGenerator.getRandomWord(maxLength, minLength: minLength)
        while(containsSpaces(string) || checkForHypens(string)){
            string = wordGenerator.getRandomWord(maxLength, minLength: minLength)
        }
        return capitalizeFirstLetter(string)
    }
    
    private func capitalizeFirstLetter(string:String) -> String {
        let firstLetter:String = getFirstLetter(string).capitalizedString
        let restOfString:String = getStringAndSkipFirstLetter(string)
        return firstLetter + restOfString
    }
    
    private func getFirstLetter(string:String) -> String {
        return string.substringToIndex(string.startIndex.advancedBy(1))
    }
    
    private func getStringAndSkipFirstLetter(string:String) -> String {
        return string.substringFromIndex(string.startIndex.advancedBy(1))
    }
    
    private func containsSpaces(string:String) -> Bool {
        if(string.containsString(" ")){
            return true
        } else {
            return false
        }
    }
    
    private func checkForHypens(string:String) -> Bool {
        if(string.containsString("-")){
            return true
        } else {
            return false
        }
    }

    func checkForNetworkError() -> Bool {
        if(self.password.rangeOfString("NetworkError") != nil) {
            return true
        } else {
            return false
        }
    }
    
}
