//
//  ContentView.swift
//  Lab1_Daniel_Demesa-Borrett
//
//  Created by daniel demesa on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    // State variables for game logic
    @State private var number = Int.random(in: 1...100)  // Random number to check
    @State private var correctAnswers = 0  // Count of correct guesses
    @State private var wrongAnswers = 0  // Count of wrong guesses
    @State private var attempts = 0  // Total attempts
    @State private var isCorrect: Bool?  // Stores whether the last answer was correct
    @State private var showDialog = false  // Controls when results pop up
    @State private var timer: Timer?  // Timer for auto-reset

    var body: some View {
        VStack(spacing: 20) {
            // Display the number to check
            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .padding()
            
            // Buttons for Prime and Not Prime selection
            HStack {
                Button("Prime") {
                    checkAnswer(isPrime: true)
                }
                .frame(width: 150, height: 50)
                .background(isCorrect == true ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Not Prime") {
                    checkAnswer(isPrime: false)
                }
                .frame(width: 150, height: 50)
                .background(isCorrect == false ? Color.orange : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .font(.title)
            .padding()
            
            // Display feedback icon based on correctness
            if let isCorrect = isCorrect {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.system(size: 50))
            }
        }
        .onAppear {
            startTimer()  // Start the countdown timer
        }
        .alert("Results", isPresented: $showDialog) {
            Button("OK") {
                attempts = 0  // Reset attempts
            }
        } message: {
            Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)")
        }
    }

    // Function to check if the user's guess is correct
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

    // Function to determine if a number is prime
    func isPrimeNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num where num % i == 0 {
            return false
        }
        return true
    }

    // Function to reset the game with a new number
    func resetNumber() {
        number = Int.random(in: 1...100)
        stopTimer()
        startTimer()
    }

    // Function to stop the timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // Function to start the timer (resets every 5 seconds)
    func startTimer() {
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
