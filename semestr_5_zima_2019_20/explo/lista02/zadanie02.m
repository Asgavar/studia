function ret = pairwise_distances(X, Y)
  ret = sqrt(transpose(sum(X .* X)) - 2 * transpose(X) * Y + sum(Y .* Y));
endfunction

function ret = k_nearest_neighbors(k, X, Y)
  [A, Idx] = sort(pairwise_distances(X, Y), 2);
  ret = transpose(Idx(:, 1:k));
endfunction

X1 = [1, 3;
      1, 3;
      1, 3;
      1, 3];

Y1 = [3, 4, 5, 2;
      3, 4, 5, 2;
      3, 4, 5, 2;
      3, 4, 5, 2];

## zadanie 2. - faktyczne pomiary
X2 = rand(100, 1_000);
Y2 = rand(100, 1_000);

before = time;
pairwise_distances(X2, Y2);
after = time;
t1k = after - before;


X3 = rand(100, 10_000);
Y3 = rand(100, 1_000);

before = time;
pairwise_distances(X3, Y3);
after = time;
t10k = after - before;

t1k
t10k

## zadanie 3.
[_, Idx] = sort(pairwise_distances(X1, Y1), 2)
k_nearest_neighbors(1, X1, Y1)
k_nearest_neighbors(3, X1, Y1)
