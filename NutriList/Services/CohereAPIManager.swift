//
//  CohereAPIManager.swift
//  NutriList
//
//  Created by leonard on 2024-01-08.
//

import Foundation

enum RequestError: Error {
    case serializationError(String)
    case invalidURL(String)
    case networkError(String)
    case dataError(String)
    case parsingError(String)
    case predictionError(String)
}

struct ClassificationResponse: Codable {
    let classifications: [Prediction]
}

struct Prediction: Codable {
    let prediction: String
}

func fetchPrediction(input: String, completion: @escaping (Result<String, RequestError>) -> Void) {
    let headers = [
      "accept": "application/json",
      "content-type": "application/json",
      "authorization": "Bearer 83I7hPYNMeTlob2CGyKt63bMGzEwq8SiHShTMW0C"
    ]
    
    let parameters = [
        "truncate": "END",
        "inputs": [input],
        "examples": [
            ["text": "White Bread", "label": "Bakery and Bread"],
            ["text": "Croissants", "label": "Bakery and Bread"],
            ["text": "Ground Coffee", "label": "Beverages"],
            ["text": "Coca-Cola", "label": "Beverages"],
            ["text": "Whole Milk", "label": "Dairy and Eggs"],
            ["text": "Cheddar Cheese", "label": "Dairy and Eggs"],
            ["text": "Frozen Peas", "label": "Frozen Foods"],
            ["text": "Frozen Pizza", "label": "Frozen Foods"],
            ["text": "Apple", "label": "Fruits and Vegetables"],
            ["text": "Spinach", "label": "Fruits and Vegetables"],
            ["text": "Shampoo", "label": "Health and Beauty"],
            ["text": "Toothpaste", "label": "Health and Beauty"],
            ["text": "Laundry Detergent", "label": "Household Essentials"],
            ["text": "Paper Towels", "label": "Household Essentials"],
            ["text": "Sushi Rice", "label": "International Foods"],
            ["text": "Tortillas", "label": "International Foods"],
            ["text": "Ribeye Steak", "label": "Meat and Seafood"],
            ["text": "Chicken Breast", "label": "Meat and Seafood"],
            ["text": "USB Cable", "label": "Others"],
            ["text": "Headphones", "label": "Others"],
            ["text": "Olive Oil", "label": "Pantry Staples"],
            ["text": "All-purpose Flour", "label": "Pantry Staples"],
            ["text": "Dog Food", "label": "Pet Supplies"],
            ["text": "Cat Food", "label": "Pet Supplies"],
            ["text": "Potato Chips", "label": "Snacks and Sweets"],
            ["text": "Oreo Cookies", "label": "Snacks and Sweets"]
        ]
    ] as [String : Any]
    
    guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        print("Error: Unable to serialize request body")
        completion(.failure(RequestError.serializationError("Unable to serialize request body")))
        return
    }
    
    guard let url = URL(string: "https://api.cohere.ai/v1/classify") else {
        print("Error: Invalid URL")
        completion(.failure(RequestError.invalidURL("Invalid URL")))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(RequestError.networkError(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(RequestError.dataError("No data received")))
                return
            }

            do {
                let response = try JSONDecoder().decode(ClassificationResponse.self, from: data)
                if let prediction = response.classifications.first?.prediction {
                    completion(.success(prediction))
                } else {
                    completion(.failure(RequestError.predictionError("Prediction not found")))
                }
            } catch {
                completion(.failure(RequestError.parsingError("Unable to parse JSON response")))
            }
        }

        dataTask.resume()
    }
