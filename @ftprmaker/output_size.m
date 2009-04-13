function outsize = output_size(o, input_size)
% Returns output size for given input size 1x2 [X Y] matrix
X = input_size(1);
Y = input_size(2);
outsize(1) = X-1;
outsize(2) = ceil(Y/2);
