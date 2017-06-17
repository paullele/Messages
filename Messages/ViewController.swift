//
//  ViewController.swift
//  Messages
//
//  Created by apple on 15/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct PublicKey {
        var n: Int
        var e: Int
    }
    
    var publicKey: PublicKey!
    var privateKey: Int!
    
    let message = "paul are mere"
    
    var m = [Int]()
    
    func convertToBinary(_ n: Int) -> Int {
        if(n == 0) {
            return 0
        }
        
        return n % 2 + convertToBinary(n/2) * 10
    }
    
    
    func getSum(_ n: inout Int) -> [Int] {
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
    
    func modularExponentiation(_ a: Int, _ e: Int, _ n: Int) -> Int {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let keyGenerator = KeyGenerator()
        let key = keyGenerator.createKey()
        
        publicKey = PublicKey(n: key.n, e: key.e)
        privateKey = key.d
        
        print(publicKey)
        print(privateKey)
        
        decomposeMessage(message)
        
        let encryptedMessage = encrypt(m, publicKey.e, publicKey.n)
        
        print(encryptedMessage)
        
        let decryptedMessage = decrypt(encryptedMessage, privateKey, publicKey.n)
        
        print(String(decryptedMessage))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

