global class class12RemoteAction {

@RemoteAction
    public static String RemoteActionMethod(String vRemoteActionMethod){
        system.debug('RemoteActionMethod '+vRemoteActionMethod);
        return vRemoteActionMethod;
    }
    
}