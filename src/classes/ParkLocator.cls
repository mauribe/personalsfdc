public class ParkLocator {
    
    public ParkLocator() {
        string[] vstr = country('Japan');
        system.debug('vstr ==> '+vstr);
        for (string vst: vstr) {
            system.debug('vst ==> '+vst);
        }
    }
    
    public static String[] country(string countryName) {
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        return park.byCountry(countryName);
    }
}