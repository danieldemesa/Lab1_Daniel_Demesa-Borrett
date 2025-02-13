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
    @State private var attempts = 0
    @State private var isCorrect: Bool?
    @State private var showDialog = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .padding()
            
            HStack {
                Button("Prime") { checkAnswer(isPrime: true) }
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Button("Not Prime") { checkAnswer(isPrime: false) }
                    .frame(width: 150, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .font(.title)
            .padding()
            
            if let isCorrect = isCorrect {
                Text(isCorrect ? "✅ Correct" : "❌ Wrong")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.title)
            }
        }
        .onAppear {
            startTimer()
        }
        .alert("Results", isPresented: $showDialog) {
            Button("OK") {
                attempts = 0
            }
        } message: {
            Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)")
        }
    }

    func checkAnswer(isPrime: Bool) {
        let primeStatus = isPrimeNumber(number)
        isCorrect = (primeStatus == isPrime)

        if isCorrect == true {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }

        attempts += 1
        if attempts == 10 {
            showDialog = true
        }

        resetNumber()
    }

    func isPrimeNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num where num % i == 0 {
            return false
        }
        return true
    }

    func resetNumber() {
        number = Int.random(in: 1...100)
        stopTimer()
        startTimer()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1
            isCorrect = false
            resetNumber()
        }
    }
}
