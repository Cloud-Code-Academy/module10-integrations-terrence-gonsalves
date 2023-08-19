trigger ContactTrigger on Contact(before insert) {
	// When a contact is inserted
	// if DummyJSON_Id__c is null, generate a random number between 0 and 100

	//When a contact is inserted
	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API

	//When a contact is updated
	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
}