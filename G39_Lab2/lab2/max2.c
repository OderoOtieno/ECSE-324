extern int MAX_2(int x, int y);

int main() {
	int l[5] = {1,100, 5, 87, 2};
	int max_value = l[0];
	
	int len = sizeof(l)/sizeof(l[0]); //
	int i = 1;
	for (i; i<len; i++) 
		max_value = MAX_2(l[i], max_value);

	return max_value;
}
