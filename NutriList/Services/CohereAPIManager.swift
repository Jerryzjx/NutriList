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

func fetchPrediction(input: String, completion: @escaping (Result<String, RequestError>) -> Void) {
    let headers = [
      "accept": "application/json",
      "content-type": "application/json",
      "authorization": ""
    ]
    
    let parameters = [
        "truncate": "END",
        "inputs": [input],
        "examples": [
            ["text": "Baby Formula", "label": "Baby Products"],
            ["text": "Diapers", "label": "Baby Products"],
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
            ["text": "Christmas Decorations", "label": "Seasonal and Occasional"],
            ["text": "Halloween Candy", "label": "Seasonal and Occasional"],
            ["text": "Potato Chips", "label": "Snacks and Sweets"],
            ["text": "Oreo Cookies", "label": "Snacks and Sweets"],
            ["text": "Organic Apples", "label": "Specialty Items"],
            ["text": "Gluten-Free Bread", "label": "Specialty Items"]
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
            print("Error: \(error.localizedDescription)")
            completion(.failure(RequestError.networkError(error.localizedDescription)))
            return
        }
        if (error != nil) {
            print(error as Any)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse as Any)
        }
        
        guard let data = data else {
            print("Error: No data received")
            completion(.failure(RequestError.dataError("No data received")))
            return
        }
        print(data)
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let classifications = jsonResult["classifications"] as? [[String: Any]],
               let firstClassification = classifications.first,
               let prediction = firstClassification["prediction"] as? String {
                
                print("Prediction: \(prediction)")
                completion(.success(prediction))
            } else {
                print("Error: Unable to find the prediction")
                completion(.failure(RequestError.predictionError("Unable to find the prediction")))
            }
        } catch {
            print("Error: Unable to parse JSON response")
            completion(.failure(RequestError.parsingError("Unable to parse JSON response")))
        }
    }
    
    dataTask.resume()
}
