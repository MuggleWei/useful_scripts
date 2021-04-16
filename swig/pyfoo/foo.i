%module(directors="1") pyfoo
%{
#include "foo.h"
%}

%feature("director");

%include "../foo/include/foo_macro.h"
%include "../foo/include/foo_struct.h"
%include "../foo/include/foo.h"
