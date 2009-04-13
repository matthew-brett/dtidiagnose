function result = subsref(this, Struct)
% method to overload the . notation.
%   Publicize subscripted reference to private fields of object.
%
% $Id: subsref.m 6 2003-06-28 23:53:05Z matthewbrett $

result = builtin('subsref', this, Struct );