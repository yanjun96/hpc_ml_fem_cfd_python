#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 15 21:50:30 2025

@author: yanjun
"""

import random

def number_guessing_game():
    print("🎮 Welcome to the Number Guessing Game! 🎮")
    print("I'm thinking of a number between 1 and 100.")
    
    # Generate a random number between 1 and 100
    secret_number = random.randint(1, 100)
    attempts = 0
    max_attempts = 10
    
    print(f"You have {max_attempts} attempts to guess the number!")
    
    while attempts < max_attempts:
        try:
            # Get player's guess
            guess = int(input(f"\nAttempt {attempts + 1}/{max_attempts}. Enter your guess: "))
            
            # Check if the guess is valid
            if guess < 1 or guess > 100:
                print("Please enter a number between 1 and 100.")
                continue
            
            attempts += 1
            
            # Check if the guess is correct
            if guess == secret_number:
                print(f"🎉 Congratulations! You guessed the number in {attempts} attempts!")
                break
            elif guess < secret_number:
                print("📈 Too low! Try a higher number.")
            else:
                print("📉 Too high! Try a lower number.")
                
            # Give a hint after a few attempts
            if attempts == max_attempts // 2:
                if secret_number % 2 == 0:
                    print("💡 Hint: The number is even!")
                else:
                    print("💡 Hint: The number is odd!")
                    
        except ValueError:
            print("❌ Please enter a valid number!")
    
    # If player runs out of attempts
    if attempts == max_attempts and guess != secret_number:
        print(f"\n💔 Game Over! The number was {secret_number}.")
    
    # Ask if player wants to play again
    play_again = input("\nWould you like to play again? (y/n): ").lower()
    if play_again == 'y':
        number_guessing_game()
    else:
        print("Thanks for playing! 👋")

# Start the game
if __name__ == "__main__":
    number_guessing_game()