//
//  SentimentIdentifier.swift
//  Vibe
//
//  Created by Inzamam on 19/06/24.
//

import Foundation
import SwiftUI
import CoreML
import NaturalLanguage

class SentimentIdentifier : ObservableObject{
    @Published var prediction = "neutral"
    @Published var confidence = 0.0
    
    
    var model = MLModel()
    var sentimentPredictor = NLModel()
    
    init(){
        do{
            let sentiment_model = try SentimentAnalyzer(configuration: MLModelConfiguration()).model
            self.model = sentiment_model
            
            do{
                 let predictor = try NLModel(mlModel: model)
                 self.sentimentPredictor = predictor
            }catch{
                print(error)
            }
            
        }catch{
            print(error)
        }
    }
    
    
    func predict (_ text: String)
    {
        self.prediction = sentimentPredictor.predictedLabel(for: text) ?? "neutral"
        let predictionSet = sentimentPredictor.predictedLabelHypotheses(for: text, maximumCount: 1)
        self.confidence = predictionSet[prediction] ?? 0.0
    }
}
