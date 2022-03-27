//
//  KickboxResponseModel.swift
//  MailField
//
//  Created by Vladislav on 27.03.2022.
//

import Foundation

enum ResultEmailState: String {
    case deliverable
    case undeliverable
    case risky
    case unknown
}

// MARK: - KickboxResponseModel
struct KickboxResponseModel: Decodable {
    let result, reason: String?
    let role, free, disposable, acceptAll: Bool?
    let didYouMean: String?
    let sendex: Double?
    let email, user, domain: String?
    let success: Bool?
    let message: String?
    
    var resultState: ResultEmailState? {
        ResultEmailState(rawValue: result ?? "unknown")!
    }
}
