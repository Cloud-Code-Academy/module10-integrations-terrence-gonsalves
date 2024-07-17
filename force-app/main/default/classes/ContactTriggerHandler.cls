public with sharing class ContactTriggerHandler extends TriggerHandler {
    private List<Contact> newCon;
    private List<Contact> oldCon;
    private Map<Id, Contact> newConMap;
    private Map<Id, Contact> oldConMap;

    //ContactHelper ch = new ContactHelper();

    public ContactTriggerHandler() {
        this.oldCon = (List<Contact>) Trigger.old;
        this.newCon = (List<Contact>) Trigger.new;
        this.newConMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldConMap = (Map<Id, Contact>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        List<Contact> conNew = new List<Contact>();
        for (Contact con : newCon) {
            
            // When a contact is inserted
            // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
            if (con.DummyJSON_Id__c == null) {
                con.DummyJSON_Id__c = String.valueOf(Integer.valueOf(Math.random() * (100 - 1) + 1));

                SYstem.debug(':::: Random generated Dummy ID: ' + con.DummyJSON_Id__c + ' ::::');

                conNew.add(con);
            }

            //When a contact is updated
            // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
            if (Integer.valueOf(con.DummyJSON_Id__c) > 100) {
                DummyJSONCallout.postCreateDummyJSONUser(con.Id);
            } 
            
            //When a contact is inserted
            // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
            if (Integer.valueOf(con.DummyJSON_Id__c) <= 100 && con.DummyJSON_Id__c != null) {
                DummyJSONCallout.getDummyJSONUserFromId(con.DummyJSON_Id__c);
            }
        }
    }
}