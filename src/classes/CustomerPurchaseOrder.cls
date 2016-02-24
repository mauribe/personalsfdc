// One implementation of the interface for customers
public class CustomerPurchaseOrder implements PurchaseOrder {
    public Double discount(integer i) {
        system.debug('discount of: '+i);
        return .05; // Flat 5% discount

	}
}