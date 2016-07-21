//
//  MyResponseHandler.swift
//  SlackBot
//
//  Created by Chang, Hao on 7/20/16.
//
//

import Foundation
import Vapor

class MyResponseHandler: ResponseHandler{
    
    
    // Override this method to customize your bot response
    override func response(toMessage text: String) -> String?{
        return super.response(toMessage: text)
    }
    
    
    /*
    // Override this method to customize your bot response for different channel. This method calls response(toMessage:) by default.
    override func response(toMessage text: String, inChannel channel: [String : Polymorphic]) -> String? {
        
        guard let isGeneral = channel["is_general"]?.bool where isGeneral else{
            if let channelName = channel["name"]?.string {
                // Channel with name \(channelName)
                return "Hey! This is bot in the \(channelName) channel."
            }else{
                return response(toMessage: text)
            }
        }
        // General channel
        return "Hey! This is bot in the general channel."
    }
     */
 
}
