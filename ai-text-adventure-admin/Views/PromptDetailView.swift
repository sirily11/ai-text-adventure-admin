//
//  PromptDetailView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

struct PromptDetailView: View {
    let prompt: String
    
    @EnvironmentObject var promptModel: PromptModel
    
    var body: some View {
        VStack {
            PromptForm(prompt: promptModel.prompt) { value in
                await update(promptValue: value)
            }
        }
        .navigationTitle(promptModel.isLoading ? "Loading" : prompt)
        .task {
            await promptModel.fetchPrompt(by: prompt)
        }
    }
    
    func update(promptValue: CreatePromptDto) async {
        do {
            await promptModel.updatePrompt(by: prompt, prompt: promptValue)
        } catch {
            
        }
    }
}
