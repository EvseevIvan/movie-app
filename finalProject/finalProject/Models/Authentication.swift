//
//  Token.swift
//  finalProject
//
//  Created by Иван Евсеев on 06.12.2022.
//

import Foundation

struct Token: Codable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct TokenValidate: Codable {
    let success: Bool
    let expiresAt, requestToken: String
    let statusCode: Int
    let statusMessage: String


    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}




struct SessionId: Codable {
    let success: Bool
    let failure: Bool?
    let sessionID: String?
    let statusMessage: String?
    let statusCode: Int?


    enum CodingKeys: String, CodingKey {
        case success, failure
        case sessionID = "session_id"
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}



struct AccountID: Codable {
    let id: Int?
    let iso639_1: String?
    let so3166_1: String?
    let name: String?
    let include_adult: Bool?
    let username: String?
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
}

struct WatchList: Codable {
    let mediaType: String
    let mediaID: Int
    let watchlist: Bool

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case watchlist
    }
}

struct GuestSession: Codable {
    let success: Bool
    let guestSessionID, expiresAt: String

    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
