trigger CaseStatusTrigger on Case (before insert, before update) {
    for (Case caseRecord : Trigger.new) {
        // before insert logic
        if (Trigger.isInsert && String.isEmpty(caseRecord.Status)) {
            // set Status to 'New' for new cases with no Status
            caseRecord.Status = 'New';
        }
        
        // before update logic
        if (Trigger.isUpdate) {
            // retrieve the old version of the record
            Case oldCase = Trigger.oldMap.get(caseRecord.Id);
            
            // check if Internal Comments changed and Status is still 'New'
            if (caseRecord.Comments != oldCase.Comments && caseRecord.Status == 'New') {
                // update Status to 'Working'
                caseRecord.Status = 'Working';
            }
        }
    }
}