//
//  PromptDetailView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

typealias OnSubmit = (CreatePromptDto) async throws -> Void

struct PromptForm: View {
    @State var name: String = ""
    @State var prompt: String = ""
    @State var firstUserMessage: String = ""
    @State var isSubmitting = false
    let onSubmit: OnSubmit
    
    init(prompt: GetPromptDto?, onSubmit: @escaping OnSubmit) {
        if let prompt = prompt {
            self._name = .init(initialValue: prompt.name)
            self._prompt = .init(initialValue: prompt.prompt)
            self._firstUserMessage = .init(initialValue: prompt.firstUserMessage)
        }
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("First user message", text: $firstUserMessage)
            TextField("Prompt", text: $prompt, axis: .vertical)
                .lineLimit(15...15)
            HStack {
                Spacer()
                Button {
                    let prompt = CreatePromptDto(name: name, prompt: prompt, firstUserMessage: firstUserMessage)
                    Task {
                        isSubmitting = true
                        do {
                            try await onSubmit(prompt)
                        } catch {
                            
                        }
                        isSubmitting = false
                    }
                } label: {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Submmit")
                    }
                }

            }
        }
        .padding()
    }
}
