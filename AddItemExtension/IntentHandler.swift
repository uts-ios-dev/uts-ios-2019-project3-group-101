//
//  IntentHandler.swift
//  AddItemExtension
//
//  Created by Jelisha De La Cruz on 4/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        
        return self
    }
    
    func createTasks(fromTitles taskTitles: [String]) -> [INTask] {
        
    }
}

extension IntentHandler : INAddTasksIntentHandling {
    
    public func handle(intent: INAddTasksIntent, completion: @escaping (AddTaskIntentResponse) -> Void) {
        print("Handled")
    }
}

//extension IntentHandler
