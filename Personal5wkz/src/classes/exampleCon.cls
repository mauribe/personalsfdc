/*** Controller ***/
public class exampleCon {
    String uname;

    public String getUsername() {
        system.debug('getUsername');
        return uname;
    }
            
    public PageReference sayHello() {
        system.debug('sayhello');
        uname = UserInfo.getName();
        return null;
    }
            
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'nothing';
}