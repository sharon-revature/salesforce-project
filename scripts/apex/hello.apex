// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

// Call Calculator Methods
System.debug('Addition: ' + Calculator.Add(2, 3));
System.debug('Multiplication: ' + Calculator.Multiply(2, 3));
System.debug('Division: ' + Calculator.Divide(6, 3));
System.debug('Modulus: ' + Calculator.Mod(7, 3));
System.debug('Calculate Expression: ' + Calculator.Calculate('1 + 2 * 3'));
System.debug('Calculate Expression: ' + Calculator.Calculate('2 * 2 + 3'));
System.debug('Calculate Expression: ' + Calculator.Calculate('(1 + 2) * 3'));
System.debug('Calculate Expression: ' + Calculator.Calculate('((3 * (4 + 2) - 8) + 10) / 2 '));
System.debug('Calculate Expression: ' + Calculator.Calculate('(10.5 * 2 - 10) *0.5 '));
System.debug('Calculate Expression: ' + Calculator.Calculate('+'));
System.debug('Calculate Expression: ' + Calculator.Calculate('122 .223 .5465'));
System.debug('Calculate Expression: ' + Calculator.Calculate('asdf'));
System.debug('Calculate Expression: ' + Calculator.Calculate(' '));


/* Call DataLord Methods
System.debug('Number of Accounts: ' + DataLord.NumAccounts());
System.debug('Number of Hot Accounts: ' + DataLord.NumHot());
System.debug('Number of Complex Accounts: ' + DataLord.NumComplex());
System.debug('Top 5 Accounts by Revenue: ' + DataLord.BigFive());
System.debug('Last Big Opportunity: ' + DataLord.LastBigOpportunity());
System.debug('Major Players: ' + DataLord.MajorPlayers());
System.debug('Most Popular Account: ' + DataLord.MostPopularAccount());
 */