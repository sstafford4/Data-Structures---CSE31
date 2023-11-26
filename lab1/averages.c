#include <stdio.h>
#include <string.h>

int main(){

    // a helluva lot of variables to account for all of the numbers and values needed
    char num[3] = "st";
    float evens = 0;
    float odds = 0;
    float evenCount = 0;
    float oddCount = 0;
    float avg1 = 0;
    float avg2 = 0;

    int count = 1;
    int addnum;
    int r;
    int sum = 0; 
    int userNum; 

    do{ // "do" makes the program check the condition after initially executing at least once
        printf("Enter the %d%s number: ", count, num);
        scanf("%d", &userNum);
        count = count + 1; // count is what determines the suffix


    // This area of the code is solely for deciding which suffix is at the end of the counter.
    // strcpy is the only way to reassign a string like this. 
    
        if (count % 10 == 1 && count % 100 != 11){
            strcpy(num, "st");
        }
        else if (count % 10 == 2 && count % 100 != 12){
            strcpy(num, "nd");
        }
        else if (count % 10 == 3 && count % 100 != 13){
            strcpy(num, "rd");
        }
        else{
            strcpy(num, "th");
        }
        // ---------------------------------------------------------------------------------------------
        //addnum = abs(userNum);
        addnum = userNum; 

        while (addnum != 0){
            r = addnum % 10; // remainder of number, its grabbing the first integer.
            sum = sum + r; 
            addnum = addnum / 10; // getting the other numbers for the addition. 
        }
        if (sum % 2 == 0 && sum != 0){ // deciding if the sum is an even number
            evens = evens + userNum; 
            evenCount = evenCount + 1;
            sum = 0;  
        }
        else if(sum % 2 == 1 && sum != 0){ // deciding if odd
            odds = odds + userNum;
            oddCount = oddCount + 1;
            sum = 0; 
        }
    }while (userNum != 0);
        
    printf("\n");

    avg1 = evens / evenCount;
    avg2 = odds / oddCount;

    if  (avg1 != 0 && avg1 == avg1){
        printf("Average of inputs whose digits sum up to an even number: %.2f\n", avg1);
    }
    
    if (avg2 != 0 && avg2 == avg2){
        printf("Average of inputs whose digits sum up to an odd number: %.2f\n", avg2);
    }
    
    else{
        printf("There is no average to compute. \n");
    }

    return 0;
}