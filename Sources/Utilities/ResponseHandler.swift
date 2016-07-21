//
//  ResponseHandler.swift
//  SlackBot
//
//  Created by Chang, Hao on 7/20/16.
//
//

import Foundation
import Vapor

class ResponseHandler {
    
    let droplet = Droplet()
    
    func handle(event: JSON, inWebSocket webSocket: WebSocket) throws{
        guard
            let channel = event["channel"].string,
            let text = event["text"].string
            else {
                return
        }
        let channelResponse = try droplet.client.get(Slack.Url.ChannelInfo,
                                                     headers: ["token":Slack.Config.BotToken],
                                                     query: ["token":Slack.Config.BotToken,
                                                             "channel":channel],
                                                     body: HTTPBody(""))
        guard let bytes = channelResponse.body.bytes, let channelInfo = try JSON.parse(bytes)["channel"].object else{
            try send(message: response(toMessage: text), toChannelWithId: channel, inWebSocket: webSocket)
            return
        }
        
        
        try send(message: response(toMessage: text, inChannel: channelInfo),
                 toChannelWithId: channel ,
                 inWebSocket: webSocket)
    }
    
    private func send(message: String, toChannelWithId channelId: String, inWebSocket webSocket: WebSocket) throws{
        var response: JSON = [:]
        response["type"] = JSON("message")
        response["channel"] = JSON(channelId)
        response["text"] = JSON(message)
        try webSocket.send(JSON.serialize(response).string())
    }
    
    
    // MARK: - Method to override
    
    func response(toMessage text: String) -> String{
        return "Hey! This is bot."
    }
    
    
    func response(toMessage text: String, inChannel channel: [String: Polymorphic]) -> String{
        return response(toMessage: text)
    }
    
}
