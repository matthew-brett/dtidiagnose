function varargout = subsref(this, Struct)
% method to overload references to point them to list
[varargout{1:nargout}] = builtin('subsref', this.list, Struct);
