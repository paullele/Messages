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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let keyGenerator = KeyGenerator()
        let keyOperations = KeyOperations()
        let key = keyGenerator.createKey()
        
        publicKey = PublicKey(n: key.n, e: key.e)
        privateKey = key.d
        
        print(publicKey)
        print(privateKey)
        
        keyOperations.decomposeMessage(message)
        
        let encryptedMessage = keyOperations.encrypt(keyOperations.getDecomposedMessage, publicKey.e, publicKey.n)
        
        print(encryptedMessage)
        
        let decryptedMessage = keyOperations.decrypt(encryptedMessage, privateKey, publicKey.n)
        
        print(String(decryptedMessage))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

