function tf = compatible(o1, o2)
% Checks if two objects have same structure
tf = o1.n_slices == o2.n_slices & o1.n_vols == o2.n_vols;