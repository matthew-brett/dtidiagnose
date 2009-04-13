function result = subsasgn(this, Struct, rhs)
% method to point indexing to list field
this.list = builtin('subsasgn', list(this), Struct, rhs);
result = this;
return 