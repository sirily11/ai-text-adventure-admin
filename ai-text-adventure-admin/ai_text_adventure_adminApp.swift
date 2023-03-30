//
//  ai_text_adventure_adminApp.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

@main
struct ai_text_adventure_adminApp: App {
    @StateObject var promptModel: PromptModel = PromptModel()
    @AppStorage("signedIn") var signedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(promptModel)
        }
        MenuBarExtra("Auth") {
            if signedIn {
                Button("Sign Out") {
                    promptModel.signOut()
                }
            }
        }
    }
}
