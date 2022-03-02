global with sharing class GitHubConnection {
    public GitHubConnection() {

    }

    public List<Map<String,Object>> getOrgRepos(String org){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        String url = 'https://api.github.com/orgs/'+org+'/repos?per_page=1000';
        request.setEndpoint(url);
        HttpResponse response = http.send(request);
        List<Object> objVal = JSON.deserializeUntyped(response.getBody());
        for(Object obj : objVal){
            Map<String, object> repo = (Map<String, Object>)obj;
            repo.put('ExternalId', repo.get('id'));
            repo.put('DisplayUrl', repo.get('html_url'));
        }
    }
}
