package xyz.juraszek.srp;

public class Square implements Rectangular {

    private int sideLength;


    public Square(int sideLength) {
        this.sideLength = sideLength;
    }


    @Override
    public int getHeight() {
        return this.sideLength;
    }


    @Override
    public int getWidth() {
        return this.sideLength;
    }
}
