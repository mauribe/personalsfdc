public class Purchase {

    private PurchaseOrder vPurchase;
    
    public Purchase(PurchaseOrder po) {
        vPurchase = po;
    }
    public Double discount(integer i) {
        system.debug('called Purchase class');
		return vPurchase.discount(i); //called the implements class (ex. CustomerPurchaseOrder) through interface (PurchaseOrder)
        //return .02; // Flat 2% discount
	}
}