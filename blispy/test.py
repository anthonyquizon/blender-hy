import code


class TestREPL(code.InteractiveConsole):
    def __init__(self):
        super(TestREPL, self).__init__()

    def runsource(self, source, filename="<input>", symbol="single"):
        print("ok")
        return False

a = TestREPL()
a.interact()
