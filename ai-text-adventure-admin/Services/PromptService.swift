//
//  PromptService.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import Alamofire
import Foundation

enum PromptError: Error {
    case notAuthorized
}

struct AdminLoginResponse: Codable {
    let message: String?
    let detail: String?
}

struct ListPromptDto: Codable {
    let name: String
}

struct GetPromptDto: Codable {
    let name: String
    let prompt: String
    let firstUserMessage: String?

    enum CodingKeys: String, CodingKey {
        case name
        case prompt
        case firstUserMessage = "first_user_message"
    }
}

struct CreatePromptDto: Codable {
    let name: String
    let prompt: String
    let firstUserMessage: String?

    enum CodingKeys: String, CodingKey {
        case name
        case prompt
        case firstUserMessage = "first_user_message"
    }
}

class PromptService {
    func login(username: String, password: String) async throws {
        let url = "\(apiEndpoint)/admin/login"
        let task = AF.request(url, method: .post).authenticate(username: username, password: password).serializingDecodable(AdminLoginResponse.self)
        let response = await task.response
        if response.response?.statusCode != 200 {
            print("Got login status code: \(response.response?.statusCode ?? 0)")
            throw PromptError.notAuthorized
        }
    }

    func fetchPrompts() async throws -> [ListPromptDto] {
        let url = "\(apiEndpoint)/prompt"
        let task = AF.request(url, method: .get).serializingDecodable([ListPromptDto].self)
        let value = try await task.value
        return value
    }

    func fetchPrompt(by name: String) async throws -> GetPromptDto {
        var url = URL(string: "\(apiEndpoint)/prompt/")!
        url.append(path: name)
        let task = AF.request(url, method: .get).serializingDecodable(GetPromptDto.self)
        let value = try await task.value
        return value
    }

    func createPrompt(username: String, password: String, prompt: CreatePromptDto) async throws {
        let url = "\(apiEndpoint)/prompt"
        let task = AF.request(url, method: .post, parameters: prompt, encoder: JSONParameterEncoder.default)
            .authenticate(username: username, password: password).serializingDecodable(AdminLoginResponse.self)
        let response = await task.response
        if response.response?.statusCode != 200 {
            print("Got create prompt status code: \(response.response?.statusCode ?? 0)")
            throw PromptError.notAuthorized
        }
    }

    func updatePrompt(username: String, password: String, name: String, prompt: CreatePromptDto) async throws {
        var url = URL(string: "\(apiEndpoint)/prompt")!
        url.append(path: name)
        let task = AF.request(url, method: .patch, parameters: prompt, encoder: JSONParameterEncoder.default)
            .authenticate(username: username, password: password).serializingDecodable(AdminLoginResponse.self)
        let response = await task.response
        if response.response?.statusCode != 200 {
            print("Got update prompt status code: \(response.response?.statusCode ?? 0)")
            throw PromptError.notAuthorized
        }
    }

    func deletePrompt(username: String, password: String, name: String) async throws {
        var url = URL(string: "\(apiEndpoint)/prompt")!
        url.append(path: name)
        let task = AF.request(url, method: .delete)
            .authenticate(username: username, password: password).serializingDecodable(AdminLoginResponse.self)
        let response = await task.response
        if response.response?.statusCode != 200 {
            print("Got delete prompt status code: \(response.response?.statusCode ?? 0)")
            throw PromptError.notAuthorized
        }
    }
}
