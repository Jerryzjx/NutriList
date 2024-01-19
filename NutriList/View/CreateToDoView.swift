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
            Text("Create A ToDo")
                .font(.largeTitle)
            
            AppTextField(placeHolder: "Please enter your task", text: $text)
            
            Button {
                if text.count > 2 {
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
                }
            } label: {
                Text("Create")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.horizontal, 24)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Duplicate Item"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all)
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
            return "Model not loaded"
        }
        
        do {
            let prediction = try textClassifier.prediction(text: inputText)
            return prediction.label
        } catch {
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
