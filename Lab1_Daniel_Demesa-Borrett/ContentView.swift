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
            // Displays the current number
            Text("\(number)")
                .font(.custom("Helvetica Neue", size: 80))
                .fontWeight(.bold)
                .padding()
            
            HStack(spacing: 20) {
                // Button for Prime answer
                Button("Prime") {
                    evaluateAnswer(isPrime: true)
                }
                .frame(width: 160, height: 60)
                .background(isCorrect == true ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 10)

                // Button for Not Prime answer
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
            
            // Shows a check or X based on answer
            if let isCorrect = isCorrect {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.system(size: 50))
            }
        }
        .onAppear {
            startTimer()  // Starts the timer when the view appears
        }
        .alert("Results", isPresented: $showDialog) {
            // Resets the counters when the dialog is dismissed
            Button("OK") {
                correctAnswers = 0
                wrongAnswers = 0
                attempts = 0
            }
        } message: {
            Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)")  // Displays the score
        }
    }

    // Evaluates the answer based on whether the number is prime or not
    func evaluateAnswer(isPrime: Bool) {
        isCorrect = isPrimeNumber(number) == isPrime

        if isCorrect == true {
            correctAnswers += 1  // Increases correct answers if the answer is correct
        } else {
            wrongAnswers += 1  // Increases wrong answers if the answer is incorrect
        }

        attempts += 1  // Increments the attempt count
        if attempts == 10 {
            showDialog = true  // Shows the results after 10 attempts
        }

        resetNumber()  // Resets the number for the next question
    }

    // Checks if the number is prime
    func isPrimeNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        if num == 2 || num == 3 { return true }
        if num % 2 == 0 { return false }
        
        for i in stride(from: 3, through: Int(Double(num).squareRoot()), by: 2) {
            if num % i == 0 {
                return false  // Returns false if any divisor is found
            }
        }
        return true  // Returns true if no divisor is found
    }

    // Resets the current number to a new random value
    func resetNumber() {
        number = Int.random(in: 1...100)
        startTimer()
    }

    // Starts a 5-second timer to reset the number if the user doesn't answer in time
    func startTimer() {
        timer?.invalidate()  
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1  // Increments wrong answers if no answer is provided within the time limit
            isCorrect = false
            resetNumber()  // Resets the number after the timer expires
        }
    }
}

// Preview for SwiftUI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
