trigger Test1 on Account (Before update) {
    
    for(Account a : Trigger.new){
    
       Account acc = [select id,description from Account where id =: a.id];
       
       acc.description = 'RazTest2';
       
    }
    
}