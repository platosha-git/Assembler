#include <iostream>
using namespace std;

float add(float a, float b);
float sub(float a, float b);
float mul(float a, float b);
float div(float a, float b);
void xchg(float a, float b);
float sqrtAsm(float a);


int main()
{
    int choose = 0;
    while (choose != 7) {
        cout << "\nAddition.............1\n";
        cout << "Subtraction..........2\n";
        cout << "Multiplication.......3\n";
        cout << "Division.............4\n";
        cout << "Exchange.............5\n";
        cout << "Square root..........6\n";
        cout << "Exit.................7\n";

        cin >> choose;
        if (choose != 7) {
            float a = 0, b = 0; 
            cout << "Input a: ";
            cin >> a;
            cout << "Input b: ";
            cin >> b;

            switch (choose) {
            case 1:
                cout << add(a, b) << endl;
                break;
            case 2:
                cout << sub(a, b) << endl;
                break;
            case 3:
                cout << mul(a, b) << endl;
                break;
            case 4:
                cout << div(a, b) << endl;
                break;
            case 5:
                xchg(a, b);
                break;
            case 6:
                cout << sqrtAsm(a) << endl;
                break;
            }
        }
    }
    return 0;
}

float add(float a, float b)
{
    float res = 0;
    __asm {
        fld a
        fadd b
        fstp res
    }
    return res;
}

float sub(float a, float b)
{
    float res = 0;
    __asm {
        fld a
        fsub b
        fstp res
    }
    return res;
}

float mul(float a, float b)
{
    float res = 0;
    __asm {
        fld a
        fmul b
        fstp res
    }
    return res;
}

float div(float a, float b)
{
    float res = 0;
    __asm {
        fld a
        fdiv b
        fstp res
    }
    return res;
}

void xchg(float a, float b)
{
    cout << "(a; b) = " << a << " " << b << endl;
    __asm {
        fld a
        fld b
        fxch
        fstp b
        fstp a
    }
    cout << "(a; b) = " << a << " " << b << endl;
}

float sqrtAsm(float a)
{
    float res = 0;
    __asm {
        fld a
        fsqrt
        fstp res
    }
    return res;
}