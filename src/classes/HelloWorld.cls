public class HelloWorld {

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
    
    
}