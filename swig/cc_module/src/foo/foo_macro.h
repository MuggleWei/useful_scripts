#ifndef CC_MODULE_FOO_MACRO_H_
#define CC_MODULE_FOO_MACRO_H_

#if WIN32 && defined(foo_USE_DLL)
	#if foo_EXPORTS
		#define CC_MODULE_FOO_EXPORT __declspec(dllexport)
	#else
		#define CC_MODULE_FOO_EXPORT __declspec(dllimport)
	#endif
#else
	#define CC_MODULE_FOO_EXPORT
#endif

#endif

