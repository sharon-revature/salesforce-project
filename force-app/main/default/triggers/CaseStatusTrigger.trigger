trigger CaseStatusTrigger on Case (before insert, before update) {
    
    // 'before insert' (new cases being created)
    if (Trigger.isInsert) {
        for (Case caseRecord : Trigger.new) {
            // ensure Status is 'New' for all newly created cases
            if (String.isEmpty(caseRecord.Status)) {
                caseRecord.Status = 'New';
            }
        }
    }
    
    // 'before update' (existing cases being updated)
    if (Trigger.isUpdate) {
        for (Case caseRecord : Trigger.new) {
            // list of before updated Cases
            Case oldCase = Trigger.oldMap.get(caseRecord.Id);
            // check if Internal Comments changed and Status is 'New'
            if (caseRecord.Comments != oldCase.Comments && caseRecord.Status == 'New') {
                caseRecord.Status = 'Working';
            }
        }
    }
}