X = rand(100, 1000);
x = rand(1, 100);
y = rand(1, 100);
w = rand(1, 100);

function dist = veclen(v)
  dist = sqrt(sum(v .* v));
endfunction

function ret = weighted_mean(v, weights)
  ret = sum(v .* weights) / length(v);
endfunction

function ret = euclidean_dist(v1, v2)
  ret = sqrt(sum((v1 .- v2) .** 2));
endfunction

function ret = dot_prod(v1, v2)
  ret = sum(v1 .* v2);
endfunction

# podpunkt a)
ans1 = veclen(x);
ans2 = weighted_mean(x, w);
ans3 = euclidean_dist(x, y);
ans4 = dot_prod(x, y);

# podpunkt b)
ans5 = sum(X .* X);
ans6 = vecnorm(w' .* X);
ans7 = sqrt(sum((y' - X) .** 2));
ans8 = sqrt(sum(y' .* X));
