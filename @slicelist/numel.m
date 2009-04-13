function [varargout] = numel(A, varargin)
if nargin == 1
varargout = {numel(A.list(:))};
else
varargout = {numel(A.list(varargin{:}))};
end