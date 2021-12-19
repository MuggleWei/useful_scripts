#include <stdlib.h>
#include <time.h>

#include "muggle/c/muggle_c.h"

// BraceWrapping::AfterExternBlock
extern "C" {}

namespace clang_format_view {

// BraceWrapping::AfterClass
class Foo
{
public:
	Foo()
		: idx_(++s_idx)
		, val_(5.0)
	{}

	int getIdx()
	{
		return idx_;
	}
	double getVal()
	{
		return val_;
	}

private:
	static int s_idx;

private:
	int idx_;
	double val_;
};
int Foo::s_idx = 0;

// BraceWrapping::AfterControlStatement
enum eFoo
{
};

// BraceWrapping::AfterStruct
typedef struct foo
{
} foo_t;

// BraceWrapping::AfterUnion
union bar
{};

typedef void (*void_fn)();
void callback(void_fn)
{}

int main()
{
	// initlaize log
	muggle_log_simple_init(MUGGLE_LOG_LEVEL_INFO, MUGGLE_LOG_LEVEL_INFO);

	// get a random number
	srand((unsigned int)time(NULL));
	double rand_num = (double)rand() / RAND_MAX;
	int i_num = (int)(10 * rand_num);

	switch (i_num)
	{
	// BraceWrapping::AfterCaseLabel
	case 1:
	{
		MUGGLE_LOG_INFO("integer value: 1");
	}
	break;
	case 2:
	{
		MUGGLE_LOG_INFO("integer value: 2");
	}
	break;
	default:
	{
		MUGGLE_LOG_INFO("integer value not equal 1 or 2");
	}
	break;
	}

	// BraceWrapping::AfterControlStatement
	if (rand_num > 0.5)
	{
		MUGGLE_LOG_INFO("rand num > 0.5");
	}
	else
	{
		// BraceWrapping::BeforeElse
		MUGGLE_LOG_INFO("rand num <= 0.5");
	}

	int i = 0;
	for (i = 0; i < i_num; i++)
	{
		MUGGLE_LOG_INFO("%d", i);
	}

	while (i > 0)
	{
		i--;
	}

	// BraceWrapping::BeforeLambdaBody
	callback([]() {
		MUGGLE_LOG_INFO("lambda");
		MUGGLE_LOG_INFO("lambda");
	});

	// BraceWrapping::BeforeWhile
	do
	{
		i++;
	} while (i < i_num);

	return 0;
}

} // namespace clang_format_view
