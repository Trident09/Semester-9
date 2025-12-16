#!/bin/bash

# Simple Calculator using Case Statement

echo "Simple Calculator"
echo "================="

# Read first number
read -p "Enter first number: " num1

# Read operator
read -p "Enter operator (+, -, *, /): " operator

# Read second number
read -p "Enter second number: " num2

# Perform calculation using case statement
case $operator in
    +)
        result=$(echo "$num1 + $num2" | bc)
        echo "Result: $num1 + $num2 = $result"
        ;;
    -)
        result=$(echo "$num1 - $num2" | bc)
        echo "Result: $num1 - $num2 = $result"
        ;;
    \*)
        result=$(echo "$num1 * $num2" | bc)
        echo "Result: $num1 * $num2 = $result"
        ;;
    /)
        if [ "$num2" -eq 0 ]; then
            echo "Error: Division by zero!"
        else
            result=$(echo "scale=2; $num1 / $num2" | bc)
            echo "Result: $num1 / $num2 = $result"
        fi
        ;;
    *)
        echo "Invalid operator! Please use +, -, *, or /"
        ;;
esac