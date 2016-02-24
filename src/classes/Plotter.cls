public class Plotter {
// This inner class manages the points
	class Point {
		Double x;
		Double y;
		Point(Double x, Double y) {
			system.debug('x '+x);
			system.debug('y '+y);
            this.x = x;
			this.y = y;
		}
		Double getXCoordinate() {
			system.debug('getXCoordinate '+x);
            return x;
		}
		Double getYCoordinate() {
			system.debug('getYCoordinate '+y);
            return y;
		}
	}
	List<Point> points = new List<Point>();
	public void plot(Double x, Double y) {
		points.add(new Point(x, y));
        system.debug ('points '+points);
	}
	// The following method takes the list of points and does something with them
	public void render() {
	}
}