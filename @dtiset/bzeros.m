function [bzs, bzis] = bzeros(o, bval_athresh)
% Method returns dtiset for vols with B nearly = 0

if nargin < 2
  bval_athresh = [];
end
if isempty(bval_athresh)
  bval_athresh = 0.1;
end
bzs = [];
if isempty(o)
  return
end
bzis = bvals(o) < bval_athresh;
bzs = o(bzis);
