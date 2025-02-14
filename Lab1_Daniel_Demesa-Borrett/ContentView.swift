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
        VStack(spacing: 30) {
            Text("\(number)")
                .font(.custom("Helvetica Neue", size: 80))
                .fontWeight(.bold)
                .padding()
            
            HStack(spacing: 20) {
                Button("Prime") {
                    evaluateAnswer(isPrime: true)
                }
                .frame(width: 160, height: 60)
                .background(isCorrect == true ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 10)

                Button("Not Prime") {
                    evaluateAnswer(isPrime: false)
                }
                .frame(width: 160, height: 60)
                .background(isCorrect == false ? Color.orange : Color.red)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            .font(.title)
            .padding()
            
            if let isCorrect = isCorrect {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.system(size: 50))
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

    func evaluateAnswer(isPrime: Bool) {
        isCorrect = isPrimeNumber(number) == isPrime

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
        if num == 2 || num == 3 { return true }
        if num % 2 == 0 { return false }
        
        for i in stride(from: 3, through: Int(Double(num).squareRoot()), by: 2) {
            if num % i == 0 {
                return false
            }
        }
        return true
    }

    func resetNumber() {
        number = Int.random(in: 1...100)
        startTimer()
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1
            isCorrect = false
            resetNumber()
        }
    }
}

// Preview for SwiftUI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
