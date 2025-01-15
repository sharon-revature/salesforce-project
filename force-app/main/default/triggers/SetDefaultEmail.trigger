trigger SetDefaultEmail on Contact (before insert) {
    // iterate through list of new contacts being inserted
    for (Contact con : Trigger.new) {
        // check if the Email field is empty
        if (String.isEmpty(con.Email)) {
            // set a default email if Email is not provided
            con.Email = con.LastName + '@email.com';
        }
    }
}