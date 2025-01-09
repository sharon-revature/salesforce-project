// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);
//System.debug(Calculator.Add (2,3));
//System.debug(Calculator.Multiply (2,3));
//System.debug(Calculator.Divide(6,3));
//System.debug(Calculator.Mod(7,3));
System.debug(DataLord.NumAccounts());
System.debug(DataLord.NumHot());
System.debug(DataLord.NumComplex());
System.debug(DataLord.BigFive());
System.debug(DataLord.LastBigOpportunity());
System.debug(DataLord.MajorPlayers());
System.debug(DataLord.MostPopularAccount());
System.debug(DataLord.TopLeadSources());