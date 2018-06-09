global class AccountService{

    webservice static String createCustomer(String Name, String Phone, String City){
        Account obj1 = new Account();
        obj1.Name = Name;
        obj1.Phone = Phone;
        obj1.BillingCity = City;
        
        insert obj1;
        
        if(obj1.Id != NULL){
            return 'Success';
        }else{
            return 'Failure';
        }
    }

}