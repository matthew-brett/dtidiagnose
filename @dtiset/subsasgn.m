function result = subsasgn(this, Struct, rhs)
% method to over load . notation in assignments.
%   Publicize subscripted assignments to private fields of object.
%
% $Id: subsasgn.m 6 2003-06-28 23:53:05Z matthewbrett $

result = builtin('subsasgn', this, Struct, rhs );