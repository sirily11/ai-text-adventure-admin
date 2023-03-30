//
//  PromptView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

struct PromptView: View {
    @EnvironmentObject var promptModel: PromptModel
    
    @State var showCreate = false
    var body: some View {
        List {
            ForEach(promptModel.prompts, id: \.name) {prompt in
                NavigationLink(prompt.name) {
                    PromptDetailView(prompt: prompt.name)
                }
                .contextMenu {
                    Button {
                        Task {
                            await promptModel.deletePrompt(by: prompt.name)
                            await promptModel.fetchPrompts()
                        }
                    } label: {
                        Text("Delete prompt")
                    }
                    
                }
            }
        }
        .contextMenu {
            Button("Create a new prompt") {
                create()
            }
        }
        .sheet(isPresented: $showCreate) {
            CreatePromptView()
        }
        .task {
            await promptModel.fetchPrompts()
        }
    }
    
    func create() {
        showCreate = true
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}
