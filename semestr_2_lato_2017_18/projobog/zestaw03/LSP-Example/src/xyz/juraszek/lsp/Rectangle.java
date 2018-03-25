package xyz.juraszek.lsp;

public class Rectangle implements Rectangular {

    private int height;
    private int width;


    public Rectangle(int height, int width) {
        this.height = height;
        this.width = width;
    }


    @Override
    public int getHeight() {
        return this.height;
    }


    @Override
    public int getWidth() {
        return this.width;
    }
}
