int shift(int x, i, k) {
    return x & ~(1 << k) | (((x & 1 << i) >> i) << k);
}
