@IsTest
public class AccountManagerTest {

    @IsTest
    public static void Test1(){
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        AccountManager.getAccount();
    }
    

    public static Id createTestRecord(){

        Account a = new Account();
        a.Name='Kiran Sainath';
        insert a;

        Contact c1 = new Contact();
        c1.LastName='Kiran Sainath';
        c1.AccountId=a.Id;
        insert c1;
        return a.Id;
    }
}