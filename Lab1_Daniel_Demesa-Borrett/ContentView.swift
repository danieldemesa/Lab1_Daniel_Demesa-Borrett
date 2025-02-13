//
//  ContentView.swift
//  Lab1_Daniel_Demesa-Borrett
//
//  Created by daniel demesa on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var isCorrect: Bool?

    var body: some View {
        VStack(spacing: 20) {
            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .padding()
            
            HStack {
                Button("Prime") { checkAnswer(isPrime: true) }
                Button("Not Prime") { checkAnswer(isPrime: false) }
            }
            .font(.title)
            .padding()
            
            if let isCorrect = isCorrect {
                Text(isCorrect ? "✅ Correct" : "❌ Wrong")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.title)
            }
        }
    }

    func checkAnswer(isPrime: Bool) {
        let primeStatus = isPrimeNumber(number)
        isCorrect = (primeStatus == isPrime)
        number = Int.random(in: 1...100)
    }

    func isPrimeNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num where num % i == 0 {
            return false
        }
        return true
    }
}
