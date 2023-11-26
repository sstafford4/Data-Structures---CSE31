#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int size; // Variable to record size of original array arr
int evenCount = 0, oddCount = 0; // Variables to record sizes of new arrays arr_even and arr_odd
int *arr; // Dynamically allocated original array with #elements = size
int *arr_even;  // Dynamically allocated array with #elements = #even elements in arr (evenCount)
int *arr_odd;   // Dynamically allocated array with #elements = #odd elements in arr (oddCount)
char *str1 = "Original array's contents: ";
char *str2 = "Contents of new array containing even elements from original: ";
char *str3 = "Contents of new array containing odd elements from original: ";

int num;

// DO NOT change the definition of the printArr function when it comes to 
// adding/removing/modifying the function parameters, or changing its return 
// type. 
void printArr(int *a, int size, char *prompt){
	if (size != 0){
        printf("\n%s", prompt);
        for (int i = 0; i < size; i++){
            printf("%d ", *(a + i));
        }
    }
    else{
        printf("\n%s empty", prompt);
    }

}

// DO NOT change the definition of the arrCopy function when it comes to 
// adding/removing/modifying the function parameters, or changing its return 
// type. 
void arrCopy(){ 
	for (int i = 0; i < size-1; i++){
        if (*(arr + i) % 2 == 0){
            *(arr_even+i)= *(arr+i);
        }
        //else if (*(arr) % 2 == 1){
        else{
            *(arr_odd+i)= *(arr+i);
        }
    }
}

int main(){
    int i;
    printf("Enter the size of array you wish to create: ");
    scanf("%d", &size);
    
    // Dynamically allocate memory for arr (of appropriate size)
    arr = (void*)(malloc(sizeof(int) * size));

    // Ask user to input content of arr and compute evenCount and oddCount
	for (int i = 0; i < size; i++){
        printf("Enter array element #%d: ", i+1);
        scanf("%d", &num);
        *(arr + i) = num;
        if (num % 2 == 0){
            evenCount++;
        }
        else if (num % 2 == 1){
            oddCount++;
        }
    }
    // Dynamically allocate memory for arr_even and arr_odd (of appropriate size)
    arr_even = (void*)(malloc(sizeof(int) * evenCount));
    arr_odd = (void*)(malloc(sizeof(int) * oddCount));   
	
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	// Print original array
    printArr(arr, size, str1);

	/// Copy even elements of arr into arr_even and odd elements into arr_odd
    arrCopy();

    // Print new array containing even elements from arr
    printArr(arr_even, evenCount, str2);

    // Print new array containing odd elements from arr
    printArr(arr_odd, oddCount, str3);

    printf("\n");
    //evenCount and oddCount are both working properly. 
    // printf("%d\n", evenCount);
    // printf("%d\n", oddCount);

    free(arr);
    free(arr_even);
    free(arr_odd);

    return 0;
}