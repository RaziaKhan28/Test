public class readOnlyRemote{

   
 @RemoteAction
 @readOnly
    public static List<Account> getRemoteTotalAccounts(){
        return [SELECT name FROM Account];
      
    }

}