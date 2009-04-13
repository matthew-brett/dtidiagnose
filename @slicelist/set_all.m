function o = set_all(o)
% Return slicelist from example o, with all possible slices included
o.list = repmat({1:o.n_slices},o.n_vols,1);
