#include <iostream>
using namespace std;

int for_house(int n);
int main() {
	const int target = 29000000;
	int start = 300000;
	int r;
	while (true) {
		cout<<start<<endl;
                r = for_house(start);
		if (r >= target) {
			break;
		}
		start++;
	}
	cout<<"answer is: "<<start<<endl;
	return 0;
}

int for_house(int n) {
	int res = 0;
	for (int i=1; i<=n; i++) {
		if ((n%i == 0) && (n/i <= 50)) {
			res += 11 * i;
		}
	}
	return res;
}

