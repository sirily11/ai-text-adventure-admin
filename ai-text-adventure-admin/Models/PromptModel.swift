//
//  PromptModel.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import Foundation

class PromptModel: ObservableObject {
    let service = PromptService()
    @Published var prompts: [ListPromptDto] = []
    @Published var prompt: GetPromptDto? = nil
    @Published var isLoading = false

    func login(username: String, password: String) async -> Bool {
        do {
            try await service.login(username: username, password: password)
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set(true, forKey: "signedIn")
            return true
        } catch {
            return false
        }
    }

    @MainActor
    func fetchPrompts() async {
        do {
            print("Fetching prompts")
            prompts = try await service.fetchPrompts()
            print(prompts)
        } catch {}
    }

    @MainActor
    func fetchPrompt(by name: String) async {
        isLoading = true
        do {
            prompt = try await service.fetchPrompt(by: name)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        isLoading = false
    }

    @MainActor
    func updatePrompt(by name: String, prompt: CreatePromptDto) async {
        do {
            let username = UserDefaults.standard.string(forKey: "username")!
            let password = UserDefaults.standard.string(forKey: "password")!

            try await service.updatePrompt(username: username, password: password, name: name, prompt: prompt)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createPrompt(prompt: CreatePromptDto) async {
        do {
            let username = UserDefaults.standard.string(forKey: "username")!
            let password = UserDefaults.standard.string(forKey: "password")!

            try await service.createPrompt(username: username, password: password, prompt: prompt)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func deletePrompt(by name: String) async {
        do {
            let username = UserDefaults.standard.string(forKey: "username")!
            let password = UserDefaults.standard.string(forKey: "password")!

            try await service.deletePrompt(username: username, password: password, name: name)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
