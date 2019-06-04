//
//  AddItemHandler.swift
//  AddItemExtension
//
//  Created by Jelisha De La Cruz on 5/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation
import Intents

class AddItemHandler : NSObject, AddItemIntentHandling {
    
    func confirm(intent: AddItemIntent, completion: @escaping (AddItemIntentResponse) -> Void) {
        print("confirmed")
    }
    
    func handle(intent: AddItemIntent, completion: @escaping (AddItemIntentResponse) -> Void) {
        print("handled")
    }
}
