public with sharing class Calculator {
    public Double Add(Double a, Double b) {
        return a + b;
    }
    
    public Double Multiply(Double a, Double b) {
        // a*b = a+a+a+...+a (b times)
        Double product = 0;
        for (Integer i = 0; i < b; i++){
            product = Add(product, a);
        }
        return product;
    }
    
    public Double Divide(Double a, Double b) {
        if (b == 0) {
            return 0;
        }
        // if b is negative, return negative value
        if (b < 0) {
            return -Divide(a, -b);
        }
        // a/b = a - b - b - b - ... until a < b
        // count how many times we can subtract b from a
        // use remainder to keep track of the remaining value
        Double quotient = 0;
        Double remainder = a;
        while (remainder >= b){
            remainder = Add(remainder, -b);
            quotient++;
        }
        return quotient;
    }
    
    public Double Mod(Double a, Double b) {
        if (b == 0) {
            return 0;
        }
        
        // remainder = a - b - b - b - ... until remainder < b
        Double remainder = a;
        while (remainder >= b) {
            remainder = Add(remainder, -b);
        }
        return remainder;
    }
    
    public Double Calculate(String expression) {
        // remove white spaces
        expression = expression.replaceAll('\\s+', '');
        // recursively calculate the expression
        return Evaluate(expression);
    }
    
    // helper function to recursively evaluate the expression
    public Double Evaluate(String expression) {
        if (!expression.contains('(')) {
            return EvaluateSimple(expression);
        }
        // find the innermost parentheses
        // find the last opening parentheses
        Integer startIdx = expression.lastIndexOf('(');
        // find the first closing parentheses - aka the corresponding closing parentheses for the last opening parentheses
        Integer endIdx = expression.indexOf(')', startIdx);
        // use substring to get the expression inside the parentheses (startIndex + 1 exclude opening parentheses)
        String innerExpression = expression.substring(startIdx + 1, endIdx);
        // evaluate the inner expression
        Double result = Evaluate(innerExpression);
        String newExpression = expression.substring(0, startIdx) + result + expression.substring(endIdx + 1);
        // recursively evaluate the new expression (until no parentheses left)
        return Evaluate(newExpression);
    }
    
    public Double EvaluateSimple(String expression) {
        List<Double> numbers = new List<Double>();
        List<String> operators = new List<String>();
        
        // parse the expression to get numbers
        String num = '';
        for (Integer i = 0; i < expression.length(); i++) {
            String c = expression.substring(i, i + 1);
            // if c is a digit or a decimal point, add it to the number
            if (c.isNumeric() || c == '.') {
                num += c;
            } else {
                // if c not number and num is not empty, add it to the list of numbers then reset num
                if (!String.isBlank(num)) {
                    numbers.add(Double.valueOf(num));
                    num = '';
                }
                // if c is an operator, add the number to the list of numbers
                if (c == '+' || c == '-' || c == '*' || c == '/') {
                    operators.add(c);
                }
            }
            // add the last number to the list of numbers if num is not empty
            if (!String.isBlank(num)) {
                numbers.add(Double.valueOf(num));
            }
        }
        
        // apply the operations in order of precedence */ -> +-
        for (Integer i = 0; i < operators.size(); i++) {
            String operator = operators[i];
            if (operator == '*' || operator == '/') {
                // get the two numbers to apply the operation
                Double num1 = numbers[i];
                Double num2 = numbers[i + 1];
                // apply the operation
                Double result = 0;
                if (operator == '*') {
                    result = Multiply(num1, num2);
                } else {
                    result = Divide(num1, num2);
                }
                // replace the two numbers with the result and remove the operator
                numbers[i] = result;
                numbers.remove(i + 1);
                operators.remove(i);
                // to account for the removed operator
                i--;
            }
            if (operator == '+' || operator == '-') {
                // get the two numbers to apply the operation
                Double num1 = numbers[i];
                Double num2 = numbers[i + 1];
                // apply the operation
                Double result = 0;
                if (operator == '+') {
                    result = Add(num1, num2);
                } else {
                    result = Add(num1, -num2);
                }
                // replace the two numbers with the result and remove the operator
                numbers[i] = result;
                numbers.remove(i + 1);
                operators.remove(i);
                // to account for the removed operator
                i--;
            }
        }
        // the result is the only number left
        return numbers[0];
    }
}