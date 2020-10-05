#include <iostream>
using namespace std;

int main() {
	int orignalNumber;
	cin>>orignalNumber;
	if(orignalNumber%4){
	    orignalNumber--;
	}
	else{
	    orignalNumber++;
	}
	cout<<orignalNumber;
	return 0;
}
