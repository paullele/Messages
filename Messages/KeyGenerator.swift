//
//  DataEncryption.swift
//  Messages
//
//  Created by apple on 16/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class KeyGenerator {
    
    private func checkPrime(_ number: Int) -> Bool {
        
        if(number == 2 || number == 3) {
            return true
        }
        
        for i in 2...number/2 {
            if(number % i == 0) {
                return false
            }
        }
        
        return true
    }
    
    private func generatePrime() -> Int {
        
        let rand = Int(arc4random_uniform(50) + 10)
        
        if(checkPrime(rand)) {
            return rand
        }
        
        return generatePrime()
    }
    
    private func gcd(_ a: Int, _ b: Int) -> Int {
        
        var a = a
        var b = b
        
        if(a == 0) {
            return b
        }
        
        while(b != 0)
        {
            if(a > b) {
                a -= b
            } else {
                b -= a
            }
        }
        
        return a
    }
    
    private func publicExponent(_ phi: Int) -> Int {
        
        let e = Int(arc4random_uniform(UInt32(20)) + 2)
        
        if(1 < e && e < phi && gcd(e, phi) == 1) {
            return e
        }
        
        return publicExponent(phi)
    }
    
    private func privateKey(_ e: Int, _ phi: Int) -> Int {
        let k = Int(arc4random_uniform(30) + 2)
        if(((k * phi) + 1) % e == 0 && ((k * phi) + 1) / e != e ) {
            return ((k * phi) + 1) / e
        }
        
        return privateKey(e, phi)
    }
    
    func createKey() -> (n: Int, e: Int, d: Int) {
        
        let p1 = generatePrime()
        let p2 = generatePrime()
        let n = p1 * p2
        let phi = (p1 - 1) * (p2 - 1)
        let e = publicExponent(phi)
        let d = privateKey(e, phi)
        
        return (n, e, d)
    }
}





