//
//  KeyOperations.swift
//  Messages
//
//  Created by apple on 19/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class KeyOperations {
    
    private var m = [Int]()
    
    private func convertToBinary(_ n: Int) -> Int {
        if(n == 0) {
            return 0
        }
        
        return n % 2 + convertToBinary(n/2) * 10
    }
    
    
    private func getSum(_ n: inout Int) -> [Int] {
        var sum = [Int]()
        
        n = convertToBinary(n)
        var e = 0
        
        while(n > 0) {
            let exp = n % 10 * Int(pow(Double(2), Double(e)))
            
            if(exp != 0) {
                sum.append(exp)
            }
            
            n = n / 10
            e += 1
        }
        
        return sum
    }
    
    private func modularExponentiation(_ a: Int, _ e: Int, _ n: Int) -> Int {
        if(e == 1) {
            return a
        }
        return Int(pow(Double(modularExponentiation(a, e/2, n)), Double(2))) % n
    }
    
    func decomposeMessage(_ message: String) {
        for c in message.characters {
            m.append(Int(UnicodeScalar(String(c))!.value))
        }
    }
    
    var getDecomposedMessage: [Int] {
        get {
            return m
        }
    }
    
    func encrypt(_ message: [Int], _ e: Int, _ n: Int) -> [Int] {
        var encryptedMessage = [Int]()
        
        for m in message {
            
            var c = 1
            var d = e
            let sum = getSum(&d)
            
            for e in sum {
                c *= modularExponentiation(m, e, n)
            }
            
            c = c % n
            
            encryptedMessage.append(c)
        }
        
        return encryptedMessage
    }
    
    func decrypt(_ message: [Int], _ privateKey: Int, _ n: Int) -> [Character] {
        
        var decryptedMessage = [Character]()
        
        for c in message {
            var m = 1
            var d = privateKey
            let sum = getSum(&d)
            
            for e in sum {
                m *= modularExponentiation(c, e, n)
            }
            
            m = m % n
            decryptedMessage.append(Character(UnicodeScalar(m)!))
        }
        
        return decryptedMessage
    }
}
