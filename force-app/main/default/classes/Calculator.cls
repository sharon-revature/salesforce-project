public with sharing class Calculator {
    public static Integer Add(Integer a, Integer b) {
        return a + b;
    }
    
    public static Integer Multiply(Integer a, Integer b) {
        // a*b = a+a+a+...+a (b times)
        Integer product = 0;
        for (Integer i = 0; i < b; i++){
            product = Add(product, a);
        }
        return product;
    }
    
    public static Integer Divide(Integer a, Integer b) {
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
        Integer quotient = 0;
        Integer remainder = a;
        while (remainder >= b){
            remainder = Add(remainder, -b);
            quotient++;
        }
        return quotient;
    }
    
    public static Integer Mod(Integer a, Integer b) {
        if (b == 0) {
            return 0;
        }
        
        // remainder = a - b - b - b - ... until remainder < b
        Integer remainder = a;
        while (remainder >= b) {
            remainder = Add(remainder, -b);
        }
        return remainder;
    }
    
    public static Double Calculate(String expression) {
        // remove white spaces
        expression = expression.replaceAll('\\s+', '');
        // recursively calculate the expression
        return Evaluate(expression);
    }
    
    // helper function to recursively evaluate the expression
    public static Double Evaluate(String expression) {
        if (!expression.contains('(')) {
            return EvaluateSimple(expression);
        }
        // find the innermost parentheses
        // find the last opening parentheses
        Integer startIdx = expression.lastIndexOf('(');
        // find the first closing parentheses - aka the corresponding closing parentheses for the last opening parentheses
        Integer endIdx = expression.indexOf(')', startIdx);
        if (endIdx == -1) {
            throw new IllegalArgumentException('Mismatched parentheses in expression: ' + expression);
        }
        // use substring to get the expression inside the parentheses (startIndex + 1 exclude opening parentheses)
        String innerExpression = expression.substring(startIdx + 1, endIdx);
        // evaluate the inner expression
        Double result = Evaluate(innerExpression);
        String newExpression = expression.substring(0, startIdx) + result + expression.substring(endIdx + 1);
        // recursively evaluate the new expression (until no parentheses left)
        return Evaluate(newExpression);
    }
    
    public static Double EvaluateSimple(String expression) {
        List<Double> numbers = new List<Double>();
        List<String> operators = new List<String>();
        
        // parse the expression to get numbers
        String num = '';
        for (Integer i = 0; i < expression.length(); i++) {
            String c = expression.substring(i, i + 1);
            // if c is a digit or a decimal point, add it to the number
            if (c.isNumeric() || c == '.') {
                num += c;
            }
            // c is a math operator
            else if (c == '+' || c == '-' || c == '*' || c == '/') {
                // if there's no number before the operator, throw an exception
                if (String.isBlank(num)) {
                    throw new IllegalArgumentException('Missing number before operator: ' + c);
                }
                numbers.add(Double.valueOf(num));
                operators.add(c);
                num = '';
            }
            // else c is not a math operator
            else {
                throw new IllegalArgumentException('Invalid symbol found: ' + c);
            }
        }
        // add the last number to the list of numbers if num is not empty
        if (!String.isBlank(num)) {
            numbers.add(Double.valueOf(num));
        }
        // if there's no operator
        else if (operators.size() == 0) {
            throw new IllegalArgumentException('No operators found in the expression.');
        }
        
        // apply the operations in order of precedence */ -> +-
        // loop for all * and / first
        for (Integer i = 0; i < operators.size(); i++) {
            String operator = operators[i];
            if (operator == '*' || operator == '/') {
                // get the two numbers to apply the operation
                Double num1 = numbers[i];
                Double num2 = numbers[i + 1];
                // apply the operation
                Double result = 0;
                if (operator == '*') {
                    result = num1 * num2;
                } else {
                    result = num1 / num2;
                }
                // replace the two numbers with the result and remove the operator
                numbers[i] = result;
                numbers.remove(i + 1);
                operators.remove(i);
                // to account for the removed operator
                i--;
            }
        }
        // loop for + and -
        for (Integer i = 0; i < operators.size(); i++) {
            String operator = operators[i];
            if (operator == '+' || operator == '-') {
                // get the two numbers to apply the operation
                Double num1 = numbers[i];
                Double num2 = numbers[i + 1];
                // apply the operation
                Double result = 0;
                if (operator == '+') {
                    result = num1 + num2;
                } else {
                    result = num1 - num2;
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