Public class AccountTable

{

    public String size { get; set; }

    //This is Our collection of the class/wrapper objects WrapperContactWrapper

    Public List<WrapperContactWrapper> wrapperlist;

    Public Integer noOfRecords{get; set;}

    // Create a new Map to verify whether the Account is already added in the Map

    Map <id,Account> SelectedAccountMap = new Map <id,Account>();

    public boolean display{get;set;}

    public list<Account> selectedList {get;set;}

    // instantiate the StandardSetController from a query locator

    public ApexPages.StandardSetController Setcon

    {

        get

        {

            if(Setcon == Null)

            {

            Setcon = new ApexPages.StandardSetController(Database.getQueryLocator([Select Name,Fax,Industry from Account]));

            // sets the number of records in each page set

            setCon.setpagesize(2000);

            noOfRecords = setCon.getResultSize();

            }

            return Setcon;

        }

        set;

    }

    //Returns a list of wrapper objects for the sObjects in the current page set

    Public List<WrapperContactWrapper> getAccount()

    {

        getSelectedAccount();

        // Initilaize the list to add the selected Account

        wrapperlist = new List <WrapperContactWrapper>();

        for(Account cc : (List<Account>)Setcon.getRecords())

        {

            if( SelectedAccountMap.ContainsKey(cc.id))

            {

                wrapperlist.add (new WrapperContactWrapper(cc,true));

            }

            else

            {

                wrapperlist.add(new WrapperContactWrapper(cc,false));

            }

        }

        return wrapperlist;
    }

    public void getSelectedAccount(){

        if(wrapperlist!=null)

        {

            for(WrapperContactWrapper wr:wrapperlist)

            {

                if(wr.bool == true)

                {

                    SelectedAccountMap.put(wr.con.id,wr.con); // Add the selected Account id in to the SelectedAccountMap.

                }

                else

                {

                    SelectedAccountMap.remove(wr.con.id); // If you uncheck the Account, remove it from the selectedAccountMap

                }

            }

        }

    }

    public void clickMe()

    {

        display = true;

        getSelectedAccount();


        selectedList = SelectedAccountMap.values();

    }

    public integer pageNumber

    {

        get

        {

            return Setcon.getPageNumber();

        }

        set;

    }

}