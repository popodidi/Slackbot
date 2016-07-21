//
//  main.swift
//  SlackBot
//
//  Created by Chang, Hao on 13/07/2016.
//
//


import Foundation
import Vapor

let handler = MyResponseHandler()
let droplet = Droplet()

// MARK: -Connect Web Socket
func botOn() throws{
    
    let headers: Headers = ["Accept": "application/json; charset=utf-8"]
    let query: [String: CustomStringConvertible] = [
        "token": Slack.Config.BotToken,
        "simple_latest": true,
        "no_unreads": true
    ]
    let body = HTTPBody()
    
    let rtmResponse = try droplet.client.get(Slack.Url.RtmStart, headers: headers, query: query, body: body)
    guard let webSocketURL = rtmResponse.data["url"].string else{
        print("Please set the Bot token in Config.swift")
        return
    }
    
    try WebSocket.connect(to: webSocketURL) { webSocket in
        print("Connected to \(webSocketURL)")
        
        webSocket.onText = { webSocket, text in
            print("EVENT: \(text)")
            let event = try Vapor.JSON.parse(Array(text.utf8))
            try handler.handle(event: event, inWebSocket: webSocket)
        }
        
        webSocket.onClose = { webSocket, _, _, _ in
            print("\n[CLOSED]\n")
        }
    }
}

try botOn()
