public class HelloWorld {
<<<<<<< HEAD

    public helloworld(){
        system.debug('constructor');
        innerclass01();
    }
    void innerclass01(){
        system.debug('inner class');
    }
    
    class plot {
        integer x;
        integer y;
        plot(integer x, integer y){
            this.x = x;
            this.y = y;
        }
        integer getx(){
            return x;
        }
        integer gety(){
            return y;
        }
        
    }
    
    
    public List<plot> addplot(integer a, integer b){
    	list<plot> p = new list<plot>();
        p.add(new plot(a,b));
        return p;
    }
=======
public Wether vW;
    public HelloWorld() {
	    this.vW = Wether.SUMMer;
        system.debug('vW => '+vW);
        
    }
    
    public enum Wether {SUMMER, WINTER}
    
>>>>>>> 1aa770a91f5e6ba9b1fe0c3feb4b991303a98436
    
    
}