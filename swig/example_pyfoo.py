import build.pyfoo as pyfoo


class MyFooSpi(pyfoo.FooSpi):
    def __init__(self):
        super().__init__()

    def syncCallback(self, x):
        print("sync callback: {}".format(x))

    def asyncCallback(self, x):
        print("async callback: {}".format(x))


if __name__ == "__main__":
    api = pyfoo.FooApi()
    spi = MyFooSpi()

    api.setSpi(spi)
    api.syncCall(5)
    api.asyncCall(6)
