
int main(void)
{
	int a[5] = {1, 20, 3, 4, 5};
	int max_val=a[0];

	int i=0;
	int len = sizeof(a)/sizeof(a[0]);//
	for (i; i<len; i++) {
		if (a[i] > max_val) {
			max_val = a[i];
		}
	}

	return max_val;
}
