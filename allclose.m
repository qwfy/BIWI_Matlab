function isClose = allclose(a, b)
    isClose = all(abs(a - b) < 0.0001);
end