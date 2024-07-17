public with sharing class ContactHelper {
    public static void beforeInsertActions(List<Contact> contactList) {
		for (Contact con : contactList) {
            System.debug(':::: This is the value of con.DummyJSON_Id__c: ' + con.DummyJSON_Id__c + ' ::::');

            // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
            if (con.DummyJSON_Id__c == null) {
                con.DummyJSON_Id__c = String.valueOf(Integer.valueOf(Math.random() * (100 - 1) + 1));
            }

            // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
            if (Integer.valueOf(con.DummyJSON_Id__c) <= 100) {
                getDummyJSONUserFromIdHelper(con.DummyJSON_Id__c);
            }
        }
    }

    public static void createPostDummyJSONUser(List<Contact> contactList) {
        for (Contact con : contactList) {

            // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
            if (Integer.valueOf(con.DummyJSON_Id__c) > 100) {
                postCreateDummyJSONUserHelper(con.Id);
            } 
        }
    }

    @future (callout=true)
    private static void getDummyJSONUserFromIdHelper(String jsonId) {
        DummyJSONCallout.getDummyJSONUserFromId(jsonId);
    }

    @future (callout=true)
    private static void postCreateDummyJSONUserHelper(String contactId) {
        DummyJSONCallout.postCreateDummyJSONUser(contactId);
    }
}