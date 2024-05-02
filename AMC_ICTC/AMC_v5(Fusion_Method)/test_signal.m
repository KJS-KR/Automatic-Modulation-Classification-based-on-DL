

bit = randi([0 7], 1000, 1);

b=rand*-0.1+rand*0.1
c=rand*-0.1+rand*0.1
a = pammod(bit, 8);
a = awgn(a, 10);
scatterplot(a)


