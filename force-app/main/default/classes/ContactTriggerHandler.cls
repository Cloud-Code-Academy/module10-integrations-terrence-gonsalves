public with sharing class ContactTriggerHandler extends TriggerHandler {
    private List<Contact> newCon;
    private List<Contact> oldCon;
    private Map<Id, Contact> newConMap;
    private Map<Id, Contact> oldConMap;

    public ContactTriggerHandler() {        
        if (System.isFuture()) {
            return;
        }

        this.oldCon = (List<Contact>) Trigger.old;
        this.newCon = (List<Contact>) Trigger.new;
        this.newConMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldConMap = (Map<Id, Contact>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        ContactHelper.beforeInsertActions(newCon);
    }

    public override void beforeUpdate() {
        ContactHelper.createPostDummyJSONUser(newCon);
    }
}