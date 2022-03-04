#include <iostream>
using namespace std;

void lenCounter();

extern "C"
{
    void strCopy(char* dst, char* src, int len);
}

int main()
{
    int choose = 0;
    while (choose != 3) {
		cout << "\nLen counter....1\n";
		cout << "String copy....2\n";
		cout << "Exit...........3\n";

		cin >> choose;
		if (choose == 1) {
			lenCounter();
		}

		if (choose == 2) {
	    	char src[] = "String to copy from";
	    	char dst[] = "Symbols were copied";
	    	strCopy(dst, src, 6);
	    	cout << dst << endl;
		}
    }

    return 0;
}


void lenCounter()
{
    char string[] = "String to count";
    int len;

    __asm {
		mov ecx, 0ffffh;
		mov al, '\0';

		lea edi, string;
		repne scasb;

		sub ecx, 0ffffh;
		not ecx;
		mov len, ecx;
    }

    cout << "Counted len = " << len << endl;
    cout << "Real len = " << strlen(string) << endl;
}
