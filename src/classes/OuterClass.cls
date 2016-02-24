public class OuterClass {
	// Static final variable (constant) – outer class level only
	private static final Integer MY_INT;
	// Non-final static variable - use this to communicate state across triggers within a single request
	public static String sharedState;
	// Static method - outer class level only
	public static Integer getInt() { return MY_INT; }
	// Static initialization (can be included where the variable is defined)
	
    static {
		MY_INT = 2;
	}
	// Member variable for outer class
	private final String m;
	// Instance initialization block - can be done where the variable is declared, or in a constructor
	{
		m = 'a';
	}
	// Because no constructor is explicitly defined in this outer class, an implicit, no-argument, public constructor exists

    /////////// ADD CUSTOM 20160206 /////////// here is defined the constructor.
    public OuterClass() {
        
    }
    
    private MyInterface vMyInt;
    public OuterClass(MyInterface vMy) {
        this.vMyInt = vMy;
        vMy.myMethod();
    }
    
    public class checkInterface implements MyInterface {
        public void myMethod(){
            system.debug('checkInterface');
            //outerclass oc = new outerclass(new outerclass.MySecondInterface()); 
        }
	}
    
    //Executive Anonymous Windows: 
    //outerclass oc = new outerclass(new outerclass.InnerClass());
    //outerclass oc = new outerclass(new outerclass.checkInterface());
    
    // Inner interface
	public virtual interface MyInterface {
		// No access modifier is necessary for interface methods - these are always
		// public or global depending on the interface visibility
		void myMethod();
	}
	// Interface extension
	interface MySecondInterface extends MyInterface {
		Integer method2(Integer i);
	}
	// Inner class - because it is virtual it can be extended.
	// This class implements an interface that, in turn, extends another interface.
	// Consequently the class must implement all methods.
	public virtual class InnerClass implements MySecondInterface {
		// Inner member variables
		private final String s;
		private final String s2;
		// Inner instance initialization block (this code could be located above)
		{
			this.s = 'x';
		}
		// Inline initialization (happens after the block above executes)
		private final Integer i = s.length();
		// Explicit no argument constructor
		public InnerClass() {
		// This invokes another constructor that is defined later
			this('none');
		}
		// Constructor that assigns a final variable value
		public InnerClass(String s2) {
			this.s2 = s2;
		}
		// Instance method that implements a method from MyInterface.
		// Because it is declared virtual it can be overridden by a subclass.
		public virtual void myMethod() { system.debug('myMethod'); }
		// Implementation of the second interface method above.
		// This method references member variables (with and without the "this" prefix)
		public Integer method2(Integer i) { return this.i + s.length(); }
	}
	// Abstract class (that subclasses the class above). No constructor is needed since parent class has a no-argument constructor
	public abstract class AbstractChildClass extends InnerClass {
		// Override the parent class method with this signature.
		// Must use the override keyword
		public override void myMethod() { system.debug('AbstractChildClass'); }
		// Same name as parent class method, but different signature.
		// This is a different method (displaying polymorphism) so it does not need to use the override keyword
		protected void method2() {}
		// Abstract method - subclasses of this class must implement this method
		abstract Integer abstractMethod();
	}
	// Complete the abstract class by implementing its abstract method
	public class ConcreteChildClass extends AbstractChildClass {
		// Here we expand the visibility of the parent method - note that visibility cannot be restricted by a sub-class
		public override Integer abstractMethod() { return 5; }
	}
	// A second sub-class of the original InnerClass
	public class AnotherChildClass extends InnerClass {
		public AnotherChildClass(String s) {
			// Explicitly invoke a different super constructor than one with no arguments
			super(s);
		}
	}
	// Exception inner class
	public virtual class MyException extends Exception {
		// Exception class member variable
		public Double d;
		// Exception class constructor
		MyException(Double d) {
			this.d = d;
		}
		// Exception class method, marked as protected
		protected void doIt() {}
	}
	// Exception classes can be abstract and implement interfaces
	public abstract class MySecondException extends Exception implements MyInterface {
	}
    
/* Executive Anonymous Windows:     
// Construct an instance of an inner concrete class, with a user-defined constructor
OuterClass.InnerClass ic = new OuterClass.InnerClass('x');
// Call user-defined methods in the class
System.assertEquals(2, ic.method2(1));
// Define a variable with an interface data type, and assign it a value that is of
// a type that implements that interface
OuterClass.MyInterface mi = ic;
// Use instanceof and casting as usual
OuterClass.InnerClass ic2 = mi instanceof OuterClass.InnerClass ?
(OuterClass.InnerClass)mi : null;
System.assert(ic2 != null);
// Construct the outer type
OuterClass o = new OuterClass();
System.assertEquals(2, OuterClass.getInt());
// Construct instances of abstract class children
System.assertEquals(5, new OuterClass.ConcreteChildClass().abstractMethod());
// Illegal - cannot construct an abstract class
// new OuterClass.AbstractChildClass();
// Illegal – cannot access a static method through an instance
// o.getInt();
// Illegal - cannot call protected method externally
// new OuterClass.ConcreteChildClass().method2();
*/
    
    
    
    
}