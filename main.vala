class Hello : Object {
    void greeting () {
        stdout.printf ("Olá, Mundo!\n");
    }

    public static void main () {
        var hello = new Hello ();
        hello.greeting ();
    }
}

