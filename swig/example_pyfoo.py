import build.pyfoo as pyfoo


def get_cc_properties(cls):
    properties = {}
    for attr in dir(cls):
        if not callable(getattr(cls, attr)) and \
                not attr.startswith("__") and \
                not attr.startswith("this"):
            properties[attr] = getattr(cls, attr)
    return properties


class MyFooSpi(pyfoo.FooSpi):
    def __init__(self):
        super().__init__()

    def syncCallback(self, x):
        print("sync callback: {}".format(x))

    def asyncCallback(self, x):
        print("async callback: {}".format(x))

    def syncCallbackVar(self, bar):
        print("sync callback var: {}".format(get_cc_properties(bar)))

    def syncCallbackRef(self, bar):
        print("sync callback ref: {}".format(get_cc_properties(bar)))

    def syncCallbackPtr(self, bar):
        print("sync callback ptr: {}".format(get_cc_properties(bar)))


if __name__ == "__main__":
    api = pyfoo.FooApi()
    spi = MyFooSpi()

    api.setSpi(spi)
    api.syncCall(5)
    api.asyncCall(6)

    bar = pyfoo.Bar()
    bar.i = 5
    bar.f = 10.0
    bar.d = 15.0
    bar.s = "hello world"

    api.syncCallVar(bar)
    api.syncCallRef(bar)
    api.syncCallPtr(bar)
