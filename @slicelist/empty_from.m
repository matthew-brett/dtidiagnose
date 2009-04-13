function E = empty_from(o)
% Returns empty list compatible with input list
E = slicelist(o.n_vols, o.n_slices);
