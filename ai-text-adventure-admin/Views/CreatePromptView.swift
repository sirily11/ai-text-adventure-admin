//
//  PromptDetailView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

struct CreatePromptView: View {
    @EnvironmentObject var promptModel: PromptModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        PromptForm(prompt: nil) { value in
            await create(promptValue: value)
        }
        .frame(width: 800)
    }
    
    func create(promptValue: CreatePromptDto) async {
        do {
            await promptModel.createPrompt(prompt: promptValue)
            await promptModel.fetchPrompts()
            dismiss()
        } catch {
            
        }
    }
}
