public class CdyneComCls {
//wsCdyneCom
//CdyneComCls cc = new CdyneComCls();

    public CdyneComCls(){
     	wsCdyneCom.IPInformation wip = ResolveIP_Http('192.168.0.1',null);
        system.debug('wip => '+wip.City);
        system.debug('wip => '+wip.StateProvince);
        system.debug('wip => '+wip.Country);
        system.debug('wip => '+wip.Organization);
        system.debug('wip => '+wip.Latitude);
        system.debug('wip => '+wip.Longitude);
        system.debug('wip => '+wip.AreaCode);
        system.debug('wip => '+wip.TimeZone);
        system.debug('wip => '+wip.HasDaylightSavings);
        system.debug('wip => '+wip.Certainty);
        system.debug('wip => '+wip.RegionName);
        system.debug('wip => '+wip.CountryCode);
    }
    
    public static wsCdyneCom.IPInformation ResolveIP_Http(String ipAddress,String licenseKey){
        wsCdyneCom.IP2GeoSoap wsI = new wsCdyneCom.IP2GeoSoap();
        return wsI.ResolveIP_Http(ipAddress,licenseKey);
    }
        


}