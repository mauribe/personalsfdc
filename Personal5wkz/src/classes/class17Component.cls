public class class17Component {
    
    public class17Component() {
        system.debug('constructor');
    }
    
    public string vValue {get;set;}
    public string controllerValue {
        get {
            system.debug('vValue '+vValue);
            return vValue;
        }
        set {
            vValue = value;
        }
        
    }
}