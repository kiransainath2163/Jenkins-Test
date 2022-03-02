@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {

    @HttpGet
    global static Case getCaseById(){
        RestRequest request = RestContext.request;
        String caseID = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case result = [select Id, CaseNumber, Subject, Status, Origin, Priority from Case where Id =:caseID];
        return result;
    }

    @HttpPost
    global static Id createCase(String subject, String status, String origin, String priority){
        Case thisCase = new Case(Subject=subject, Status=status, Origin=origin, Priority=priority);
        insert thisCase;
        return thisCase.Id;
    }

    @HttpPut
    global static Id upsertCase(String subject, String status, String origin, String priority, String id){
        Case thisCase = new Case(Subject=subject, Status=status, Origin=origin, Priority=priority, Id=id);
        upsert thisCase;
        return thisCase.id;
    }

    @HttpDelete
    global static void deleteCase(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [select Id from Case where Id=:caseId];
        delete thisCase;
    }

    @HttpPatch
    global static ID updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }    
}