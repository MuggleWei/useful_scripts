#ifndef CC_MODULE_FOO_H_
#define CC_MODULE_FOO_H_

#include "foo_macro.h"

class FooSpi
{
public:
	virtual ~FooSpi();
	virtual void syncCallback(int x);
	virtual void asyncCallback(int x);
};

class FooApi
{
public:
	CC_MODULE_FOO_EXPORT 
	void setSpi(FooSpi *spi);

	CC_MODULE_FOO_EXPORT 
	void syncCall(int x);

	CC_MODULE_FOO_EXPORT 
	void asyncCall(int x);

private:
	FooSpi *spi_;
};

#endif
