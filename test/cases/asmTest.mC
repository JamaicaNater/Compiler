int i;
int dog;
int cat;

int add(int x, int y) {
    int result;
    result = x + y;

    return result;
}

void saydog() {
    outputchar('D');
    outputchar('o');
    outputchar('g');
    outputchar(' ');
    outputchar('=');
    outputchar(' ');
    output(dog);
    return;
}

void main(int x){
    int t;
    int testglobal;
    int z;
    char c;
    void v;
    int newline;
    int over9k;

    int num1;
    int num2;
    int result;
    int num3;

    newline = 10;

    outputchar('I');
    outputchar('n');
    outputchar('p');
    outputchar('u');
    outputchar('t');
    outputchar(' ');
    outputchar('a');
    outputchar(' ');
    outputchar('c');
    outputchar('h');
    outputchar('a');
    outputchar('r');
    outputchar(':');

    c = inputchar();  

    outputchar('c');
    outputchar('h');
    outputchar('a');
    outputchar('r');
    outputchar(':');
    outputchar(c);
    outputhexaschar(newline);

    outputchar('H');
    outputchar('e');
    outputchar('l');
    outputchar('l');
    outputchar('o');
    outputchar(' ');
    outputchar('W');
    outputchar('o');
    outputchar('r');
    outputchar('l');
    outputchar('d');
    outputchar('!');
    outputchar('!');
    outputchar('!');
    outputhexaschar(newline);

    outputchar('I');
    outputchar('n');
    outputchar('p');
    outputchar('u');
    outputchar('t');
    outputchar(' ');
    outputchar('a');
    outputchar(' ');
    outputchar('i');
    outputchar('n');
    outputchar('t');
    outputchar('1');
    outputchar(':');
    num1 = inputint();
    
    outputchar('I');
    outputchar('n');
    outputchar('p');
    outputchar('u');
    outputchar('t');
    outputchar(' ');
    outputchar('a');
    outputchar(' ');
    outputchar('i');
    outputchar('n');
    outputchar('t');
    outputchar('2');
    outputchar(':');
    num2 = inputint();

    result = add(num1, num2);
    
    output(num1);
    outputchar('+');
    output(num2);
    outputchar('=');
    output(result);
    outputhexaschar(newline);

    t = 5 + 76 * 5 + 6 - 3;

    t = 6;

    i = 3;
    
    dog = add(1, i) + 1;

    outputchar('g');
    outputchar('l');
    outputchar('o');
    outputchar('b');
    outputchar('a');
    outputchar('l');
    outputchar(' ');
    outputchar('d');
    outputchar('o');
    outputchar('g');
    outputchar(' ');
    outputchar('i');
    outputchar('s');
    outputchar(' ');
    output(dog);

    outputchar(' ');
    outputchar('f');
    outputchar('u');
    outputchar('n');
    outputchar('c');
    outputchar(' ');
    outputchar('c');
    outputchar('a');
    outputchar('l');
    outputchar('l');
    outputchar(' ');
    saydog();
    outputchar(' ');
    outputhexaschar(newline);

    outputchar('I');
    outputchar('n');
    outputchar('p');
    outputchar('u');
    outputchar('t');
    outputchar(' ');
    outputchar('a');
    outputchar(' ');
    outputchar('i');
    outputchar('n');
    outputchar('t');
    outputchar('3');
    outputchar(' ');
    outputchar('(');
    outputchar('p');
    outputchar('o');
    outputchar('w');
    outputchar('e');
    outputchar('r');
    outputchar(' ');
    outputchar('l');
    outputchar('e');
    outputchar('v');
    outputchar('e');
    outputchar('l');
    outputchar(')');
    outputchar(':');
    outputchar(' ');
    num3 = inputint();


    if (num3 > 9000) {
        over9k = 1;
        outputchar('I');
        outputchar('t');
        outputchar('s');
        outputchar(' ');
        outputchar('o');
        outputchar('v');
        outputchar('e');
        outputchar('r');
        outputchar(' ');
        outputchar('9');
        outputchar('0');
        outputchar('0');
        outputchar('0');
        outputchar('!');
        outputchar('!');
        outputchar('!');
        outputchar('!');
        
    } else {
        over9k = 0;
        outputchar('I');
        outputchar('t');
        outputchar('s');
        outputchar(' ');
        outputchar('u');
        outputchar('n');
        outputchar('d');
        outputchar('e');
        outputchar('r');
        outputchar(' ');
        outputchar('9');
        outputchar('0');
        outputchar('0');
        outputchar('0');
        outputchar(',');
        outputchar(' ');
        outputchar('w');
        outputchar('e');
        outputchar('a');
        outputchar('k');
        outputchar('!');

        outputchar(' ');
        outputchar('I');
        outputchar('t');
        outputchar('s');
        outputchar(' ');
        outputchar('t');
        outputchar('i');
        outputchar('m');
        outputchar('e');
        outputchar(' ');
        outputchar('f');
        outputchar('o');
        outputchar('r');
        outputchar(' ');
        outputchar('a');
        outputchar(' ');
        outputchar('b');
        outputchar('o');
        outputchar('o');
        outputchar('s');
        outputchar('t');
    }
    outputhexaschar(newline);

    output(num3);
    while (num3 < 9000){

        output(num3);
        outputchar(' ');

        num3 = num3 + 100;
    }

    outputhexaschar(newline);
    outputchar('F');
    outputchar('i');
    outputchar('n');
    outputchar('a');
    outputchar('l');
    outputchar(' ');
    outputchar('p');
    outputchar('o');
    outputchar('w');
    outputchar('e');
    outputchar('r');
    outputchar(' ');
    outputchar('l');
    outputchar('e');
    outputchar('v');
    outputchar('e');
    outputchar('l');
    outputchar(' ');
    outputchar('i');
    outputchar('s');
    outputchar(':');
    outputchar(' ');
    output(num3);
    outputchar(' ');
    outputhexaschar(newline);

    z = 76 > 7;
    outputchar('7');
    outputchar('6');
    outputchar(' ');
    outputchar('>');
    outputchar(' ');
    outputchar('7');
    outputchar('?');
    outputchar(' ');
    outputchar('A');
    outputchar('n');
    outputchar('s');
    outputchar(' ');
    outputchar('=');
    outputchar(' ');
    output(z);  

    return 0;
}

