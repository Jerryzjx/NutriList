//
//  CreateToDoView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI
import CoreML


struct CreateToDoView: View {
    @EnvironmentObject var viewModel: ToDoViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var predictionResult: String = ""
    @State var text = " "
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State var appUser: AppUser
    
    // Initialize the text classifier
    let textClassifier: GroceryItemClassifier_1? = {
        do {
            let configuration = MLModelConfiguration()
            return try GroceryItemClassifier_1(configuration: configuration)
        } catch {
            print("Error initializing the model: \(error)")
            return nil
        }
    }()
    
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Add a grocery item")
                .font(.title)
            
            AppTextFieldV2(placeHolder: "Enter an item", text: $text)
            
            Button {
                if text.count > 2 {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    classifyText(text)
                    /* fetchPrediction(input: text) { result in
                     DispatchQueue.main.async {
                     switch result {
                     case .success(let prediction):
                     self.predictionResult = prediction
                     Task {
                     do {
                     try await viewModel.createItem(text: text, uid: appUser.uid, category: predictionResult)
                     dismiss()
                     } catch {
                     print("Error creating ToDo item: \(error)")
                     }
                     }
                     case .failure(let error):
                     self.predictionResult = "Error: \(error)"
                     }
                     }
                     }*/
                } else {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
            } label: {
                Text("Create")
                    .font(Font.system(size: 23))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(Color(uiColor: .white))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color("LightTeal"))
                    }
            }
            .padding(.horizontal, 24)
        }
        .alert(isPresented: $showAlert) {
            
            Alert(title: Text("Duplicate Item"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
            .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.ultraThinMaterial)
                    )
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onDisappear{
                
                    Task {
                        do {
                            try await viewModel.fetchItems(for: appUser.uid)
                        } catch {
                            print(error)
                        }
                    }
                
            }
            
    }
    
    private func classifyText(_ inputText: String) {
        let capitalizedText = inputText.capitalized
        
        DispatchQueue.global(qos: .userInitiated).async {
            let result = predictCategory(for: capitalizedText)
            DispatchQueue.main.async {
                handlePredictionResult(result: result)
            }
        }
    }
    
    private func predictCategory(for inputText: String) -> String {
        guard let textClassifier = textClassifier else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return "Model not loaded"
        }
        
        do {
            let prediction = try textClassifier.prediction(text: inputText)
            return prediction.label
        } catch {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            print("Error during prediction: \(error)")
            return "Prediction failed"
        }
    }
    
    private func handlePredictionResult(result: String) {
        self.predictionResult = result
        
        Task {
            do {
                try await viewModel.createItem(text: text, uid: appUser.uid, category: predictionResult)
                dismiss()
                
            } catch let error as NSError {
                // Check if the error is the specific duplicate item error
                if error.domain == "ToDoViewModel" && error.code == 1001 {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                    alertMessage = error.localizedDescription
                    showAlert = true
                } else {
                    // Handle other NSError instances differently if needed
                    dismiss()
                }
            }
        }
    }
}



#Preview {
    CreateToDoView( appUser: .init(uid: "", email: ""))
        .environmentObject(ToDoViewModel())
}
