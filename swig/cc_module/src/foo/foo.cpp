#include "foo.h"
#include <thread>

FooSpi::~FooSpi()
{}

void FooSpi::syncCallback(int /*x*/)
{
	// sub-class override
}
void FooSpi::asyncCallback(int /*x*/)
{
	// sub-class override
}

void FooApi::setSpi(FooSpi *spi)
{
	spi_ = spi;
}

void FooApi::syncCall(int x)
{
	spi_->syncCallback(x);
}

void FooApi::asyncCall(int x)
{
	std::thread th([&, x]{
		spi_->asyncCallback(x);
	});
	th.join();
}
