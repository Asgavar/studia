package xyz.juraszek.srp;

public class Main {

    public static void main(String[] args) {

        Rectangular sq = new Square(5);
        Rectangular rect = new Rectangle(4, 5);
        AreaCalculator calc = new AreaCalculator();

        System.out.println(calc.calculateArea(sq));
        System.out.println(calc.calculateArea(rect));
    }
}
